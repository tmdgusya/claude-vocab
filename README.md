# claude-vocab

A Claude Code plugin that automatically exports your conversation prompts when sessions end.

## Features

- **Auto-export**: Automatically saves your prompts when you exit a session
- **Clean output**: Filters out tool results and system messages — only your actual typed prompts
- **Project-local**: Exports saved to `.transcriptor/` in each project

## Installation

```bash
git clone https://github.com/tmdgusya/claude-vocab ~/.claude/plugins/claude-vocab
```

## Usage

### Automatic Export

Just use Claude Code normally. When you exit a session (`/exit`, Ctrl+C, etc.), your prompts are automatically saved to:

```
.transcriptor/prompts-YYYYMMDD_HHMMSS.txt
```

### Manual Commands

- `/export-prompts` — Export prompts from a specific session
- `/list-exports` — List all exported transcripts in current project

## Output Format

Each prompt is saved on its own line, in chronological order:

```
How do I create a React component?
Can you add error handling to this function?
Make the button blue instead of green
```

## How It Works

The plugin uses a `SessionEnd` hook that:

1. Reads the session transcript (JSONL format)
2. Filters for `type: "user"` messages
3. Extracts only string content (excludes tool results)
4. Removes system-generated messages (starting with `<`)
5. Saves to `.transcriptor/` directory

## Requirements

- Claude Code 2.x+
- `jq` command-line tool (usually pre-installed on macOS/Linux)

## License

MIT
