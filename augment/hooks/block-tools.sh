#!/usr/bin/env bash
EVENT_DATA=$(cat)
COMMAND=$(echo "$EVENT_DATA" | jq -r '.tool_input.command // ""')

if echo "$COMMAND" | grep -qE "rm -rf|sudo"; then
  echo "Blocked dangerous command: $COMMAND" >&2
  exit 2  # Blocks tool, stderr shown to agent
fi

exit 0  # Allow tool to proceed