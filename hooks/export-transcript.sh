#!/bin/bash
# Transcriptor Plugin - Auto-export user prompts on session end
# Receives session data via stdin including transcript_path

STDIN_DATA=$(cat)
TRANSCRIPT_PATH=$(echo "$STDIN_DATA" | jq -r '.transcript_path')
SESSION_ID=$(echo "$STDIN_DATA" | jq -r '.session_id')
PROJECT_DIR=$(echo "$STDIN_DATA" | jq -r '.cwd')

EXPORT_DIR="$PROJECT_DIR/.transcriptor"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$EXPORT_DIR"

if [[ -f "$TRANSCRIPT_PATH" ]]; then
    # Extract only user-typed messages from JSONL transcript
    # Filters: type="user", content is string, not system messages (starting with <)
    jq -r '
        select(.type == "user") |
        select(.message.content | type == "string") |
        select(.message.content | startswith("<") | not) |
        "- " + .message.content
    ' "$TRANSCRIPT_PATH" 2>/dev/null > "$EXPORT_DIR/prompts-${TIMESTAMP}.txt"

    # Count exported prompts
    PROMPT_COUNT=$(wc -l < "$EXPORT_DIR/prompts-${TIMESTAMP}.txt" | tr -d ' ')

    # Only keep if there are actual prompts
    if [[ "$PROMPT_COUNT" -eq 0 ]]; then
        rm "$EXPORT_DIR/prompts-${TIMESTAMP}.txt"
    fi
fi

exit 0
