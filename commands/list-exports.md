---
description: List all exported transcript files
---

# List Exported Transcripts

List all user prompt exports in the current project.

## Instructions

1. Check if `.transcriptor/` directory exists in the current project
2. If it exists, list all files with their sizes and dates
3. Show a summary of total exports and date range

```bash
ls -lh .transcriptor/*.txt 2>/dev/null
```

4. If no exports exist, inform the user that exports are created automatically when sessions end, or they can use `/export-prompts` to export manually.
