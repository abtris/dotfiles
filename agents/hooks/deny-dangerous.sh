#!/bin/bash
# Global agent command guard.
# Blocks catastrophic shell commands before agents run them.
# Vendored from https://github.com/davidondrej/skills/tree/main/hooks
# Denylist: ~/.agents/hooks/dangerous-patterns.txt (one ERE regex per line).
#
# Used by:
#   Claude Code  ~/.claude/settings.json  PreToolUse (matcher Bash)
#   Codex        ~/.codex/hooks.json      PreToolUse (matcher Bash)
#   Cursor       ~/.cursor/hooks.json     beforeShellExecution (arg: cursor)
#
# stdin:  hook JSON. Claude/Codex put the command at .tool_input.command,
#         Cursor at .command.
# Block:  default mode -> exit 2 + reason on stderr (Claude/Codex contract).
#         "cursor" mode -> {"permission":"deny",...} JSON on stdout, exit 0.
# Allow:  default mode -> exit 0, silent. cursor mode -> {"permission":"allow"}.
# Ask:    a denylist line prefixed "ask:" prompts instead of blocking, for
#         commands that are usually destructive but sometimes routine.
#         default mode -> permissionDecision "ask" JSON on stdout, exit 0.
#         "cursor" mode -> {"permission":"ask",...}. This is a local addition;
#         Codex has no ask contract, so it reads those lines as allow.
# Deny wins over ask: every plain pattern is checked before any ask: pattern.

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
# Denylist sits next to this script, so the repo copy and the installed symlink
# both find it without depending on $HOME.
PATTERNS_FILE="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)/dangerous-patterns.txt"
MODE="${1:-exitcode}"

allow() {
  [ "$MODE" = "cursor" ] && printf '{"permission":"allow"}\n'
  exit 0
}

# Without jq we cannot inspect the command: fail open rather than break agents.
command -v jq >/dev/null 2>&1 || allow

INPUT=$(cat)
# .tool_input = Claude/Codex, .toolInput = Grok CLI (Claude-compat mode), .command = Cursor
CMD=$(printf '%s' "$INPUT" | jq -r '.tool_input.command // .toolInput.command // .command // empty' 2>/dev/null)

[ -z "$CMD" ] && allow
[ -f "$PATTERNS_FILE" ] || allow

# Sets MATCHED and MATCHED_NOTE to the first pattern of the requested kind that
# matches, and returns 0. $1 is "ask" to read only ask: lines, anything else to
# read only plain ones. Not called in a subshell, so the globals survive.
first_match() {
  MATCHED=
  MATCHED_NOTE=
  while IFS= read -r line; do
    case "$line" in ''|\#*) continue ;; esac
    case "$line" in
      ask:*)
        [ "$1" = ask ] || continue
        line=${line#ask:}
        ;;
      *)
        [ "$1" = ask ] && continue
        ;;
    esac
    # " ::: " ends the regex and starts a human note. No ERE contains it.
    case "$line" in
      *" ::: "*)
        pattern=${line%% ::: *}
        note=${line#* ::: }
        ;;
      *)
        pattern=$line
        note=
        ;;
    esac
    if printf '%s\n' "$CMD" | grep -qE -- "$pattern" 2>/dev/null; then
      MATCHED=$pattern
      MATCHED_NOTE=$note
      return 0
    fi
  done < "$PATTERNS_FILE"
  return 1
}

if first_match deny; then
  if [ "$MODE" = "cursor" ]; then
    jq -cn --arg p "$MATCHED" '{
      permission: "deny",
      user_message: "Command guard blocked a dangerous command.",
      agent_message: ("This command was blocked by the global dangerous-command guard (~/.agents/hooks/dangerous-patterns.txt). Matched pattern: " + $p + ". Do not retry it or try to work around the guard; explain the block to the user instead.")
    }'
    exit 0
  fi
  echo "Blocked by the global dangerous-command guard (~/.agents/hooks/dangerous-patterns.txt). Matched pattern: $MATCHED. Do not retry it or try to work around the guard; explain the block to the user instead." >&2
  exit 2
fi

if first_match ask; then
  # Laid out for someone deciding in a hurry: what runs, what it costs, where the
  # rule lives. No ANSI colour, because a prompt that renders escapes literally
  # would show the bytes instead of the emphasis.
  REASON=$(printf '%s\n' \
    "**Command guard — this needs your decision.**" \
    "" \
    "- **Running:** \`$CMD\`" \
    "${MATCHED_NOTE:+- **Risk:** $MATCHED_NOTE}" \
    "- **Approve** if you recognise that target and can recreate it." \
    "- **Deny** if a delete was not what you asked for. Nothing is retried behind your back." \
    "" \
    "Rule: \`ask:\` line in \`~/.agents/hooks/dangerous-patterns.txt\`")

  if [ "$MODE" = "cursor" ]; then
    jq -cn --arg r "$REASON" '{
      permission: "ask",
      user_message: $r,
      agent_message: $r
    }'
    exit 0
  fi
  jq -cn --arg r "$REASON" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "ask",
      permissionDecisionReason: $r
    }
  }'
  exit 0
fi

allow
