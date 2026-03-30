Load focused context for $ARGUMENTS.

1. Read the hub note or project-context file for the target
2. Read all notes in the target's folder and subfolders
3. Search /code/ for any directories matching the target name or aliases
   (e.g., /context-load commerce should also find /code/[company]/internal/commerce/)
   Read any markdown files found in matching code directories
4. Read the most recent 5 meeting notes for this client/project
5. Scan for active tasks related to the target
6. Check /_meta/entities.md for related entities and aliases
7. Search daily-notes from the past 30 days for mentions of the target

Output a focused briefing on the current state of the target:
- Overview and current status
- Recent activity (last 30 days)
- Open tasks and next steps
- Key decisions and their rationale
- Connected projects or clients
- Code/documentation: list any code project docs found and summarize key points

This is my context load for a focused work session.
