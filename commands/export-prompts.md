---
description: Export user prompts from current or previous session
argument: "[session_id]"
---

# Export User Prompts

Export only the user-typed prompts from a Claude Code session.

## Instructions

1. If no session ID is provided, list recent sessions and ask the user which one to export
2. Use this jq command to extract prompts from the transcript:

```bash
jq -r '
    select(.type == "user") |
    select(.message.content | type == "string") |
    select(.message.content | startswith("<") | not) |
    .message.content
' ~/.claude/projects/PROJECT_HASH/SESSION_ID.jsonl
```

3. Save the output to `.transcriptor/prompts-TIMESTAMP.txt` in the current project
4. Report how many prompts were exported and where the file was saved

## Finding Sessions

Sessions are stored at: `~/.claude/projects/*/`

To list recent sessions:
```bash
ls -lt ~/.claude/projects/*/*.jsonl | head -10
```

## Output Format

Each user prompt on its own line, in chronological order.
