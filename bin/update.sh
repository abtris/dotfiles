#!/usr/bin/env bash
# Update every repo in the current directory that sits on master/main.
# Clean trees are pulled; dirty trees are only fetched (never merged).
# Pure (Enterprise Managed User) repos — origin like org-XXXXXXX@github.com —
# are handled specially: configure them with purerepo when unset, skip when
# they carry a foreign user.email, pull/fetch when already the pure identity.

PURE_EMAIL="lprskavec@purestorage.com"

for name in */ ; do
  [ -d "$name" ] && [ ! -L "$name" ] || continue
  (
    cd "$name" || exit
    [ -e ".git" ] || exit

    branch=$(git branch --no-color | grep -e "^*" | tr -d ' *')
    [ "$branch" = "master" ] || [ "$branch" = "main" ] || exit
    git remote | grep -q origin || exit

    origin=$(git remote get-url origin 2>/dev/null)

    # EMU / pure repo: origin looks like org-144335849@github.com:...
    if printf '%s' "$origin" | grep -qE '^org-[0-9]+@github\.com'; then
      email=$(git config --get user.email)
      if [ -z "$email" ]; then
        printf 'Configuring pure repo: %s\n' "$name"
        purerepo
      elif [ "$email" != "$PURE_EMAIL" ]; then
        printf 'Skipping (foreign user.email=%s): %s\n' "$email" "$name"
        exit
      fi
    fi

    if [ -n "$(git status --porcelain)" ]; then
      printf 'Local changes, fetching only: %s\n' "$name"
      git fetch
    else
      printf 'Update source in directory: %s\n' "$name"
      git pull
    fi
  )
done
