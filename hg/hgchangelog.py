# -*- coding: utf-8 -*-
"""
    hgchangelog
    ~~~~~~~~~~~

    Mercurial extension to read commit message from changelog.

    Usage: activate the extension and set the name of your changelog in hgrc::

        [extensions]
        hgchangelog = path/to/hgchangelog.py

        [changelog]
        filename = CHANGES

    Then, committing without a given message or logfile will check if the
    changelog is included in the commit. If it is, the commit message shown
    in the editor will default to all text added to the changelog.

    :copyright: 2008, 2009 by Georg Brandl, Armin Ronacher.
    :license:
        This program is free software; you can redistribute it and/or modify it
        under the terms of the GNU General Public License as published by the
        Free Software Foundation; either version 2 of the License, or (at your
        option) any later version.

        This program is distributed in the hope that it will be useful, but
        WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
        Public License for more details.

        You should have received a copy of the GNU General Public License along
        with this program; if not, write to the Free Software Foundation, Inc.,
        51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
"""
import re
from mercurial import commands, cmdutil, extensions, patch


_bullet_re = re.compile(r'\s*[-+*]\s+')


def normalize_log(lines):
    """Outdents newly inserted list items."""
    last_indention = 0
    for idx, line in enumerate(lines):
        match = _bullet_re.match(line)
        if match is not None:
            last_indention = match.end()
            lines[idx] = line[last_indention:]
        elif last_indention:
            if not line[:last_indention].strip():
                lines[idx] = line[last_indention:]
    return '\n'.join(lines)


def new_commit(orig_commit, ui, repo, *pats, **opts):
    if opts['message'] or opts['logfile']:
        # don't act if user already specified a message
        return orig_commit(ui, repo, *pats, **opts)

    # check if changelog changed
    logname = ui.config('changelog', 'filename', 'CHANGES')
    if pats:
        match = cmdutil.match(repo, pats, opts)
        if logname not in match:
            # changelog is not mentioned
            return orig_commit(ui, repo, *pats, **opts)
    logmatch = cmdutil.match(repo, [logname], {})
    logmatch.bad = lambda f, msg: None  # don't complain if file is missing

    # get diff of changelog
    log = []
    for chunk in patch.diff(repo, None, None, match=logmatch):
        for line in chunk.splitlines():
            # naive: all added lines are the changelog
            if line.startswith('+') and not line.startswith('+++'):
                log.append(line[1:].rstrip().expandtabs())
    log = normalize_log(log)

    # always let the user edit the message
    opts['force_editor'] = True
    opts['message'] = log
    return orig_commit(ui, repo, *pats, **opts)


def uisetup(ui):
    if not hasattr(extensions, 'wrapcommand'):
        return # doesn't work as nicely on old hg versions
    extensions.wrapcommand(commands.table, 'commit', new_commit)
