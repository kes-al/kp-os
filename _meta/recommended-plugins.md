---
title:
type: note
client:
project:
domain:
date: 2026-03-30
tags: []
---

# {{title}}

<!-- Write freely. Use [[wikilinks]] to connect to clients, projects, people, technologies. -->
<!-- Tag ideas with #idea for /graduate to find later. -->
<!-- Add inline tasks for action items: - [ ] Task 📅 YYYY-MM-DD ⏫ -->

# Recommended Plugins

Install these from Obsidian Settings → Community Plugins → Browse.

## Essential

### Tasks
- **What:** Aggregates inline tasks (`- [ ]`) across your entire vault into filtered views
- **Why:** This replaces Notion's task database. Tasks live inside your notes where they were created, but you can query them by due date, priority, client, status
- **Setup:** Enable it. Default settings are fine. Use the emoji format for dates and priority: `📅` for due date, `⏫` high, `🔼` medium, `🔽` low

### Dataview
- **What:** Query your vault like a database using frontmatter metadata
- **Why:** Powers your dashboards. A "Today" note can have a Dataview query that pulls all active tasks due today, all notes modified today, all projects with status: active
- **Setup:** Enable. Turn on JavaScript queries if you want advanced dashboards later
- **Example query in a note:**
```dataview
TABLE client, status, date
FROM "work/projects"
WHERE status = "active"
SORT date DESC
```

### Templater
- **What:** Advanced templates with dynamic variables (dates, prompts, etc.)
- **Why:** The `{{date:YYYY-MM-DD}}` syntax in your templates needs this. Also lets you auto-create daily notes from templates
- **Setup:** Set template folder to `/templates`. Enable "Trigger Templater on new file creation"

### Calendar
- **What:** Visual calendar in the sidebar linked to daily notes
- **Why:** Click a date, it creates or opens that day's daily note from your template. Makes the daily note habit frictionless
- **Setup:** Point it to `/daily-notes` folder and the daily note template

## Recommended

### Auto Link Title
- **What:** When you paste a URL, automatically fetches the page title and formats the link
- **Why:** Cleaner notes when saving resources and references

### Various Complements
- **What:** Auto-suggests wikilinks as you type based on existing note titles
- **Why:** Speeds up manual linking. You type a word, it suggests `[[matching notes]]`

### Obsidian Git
- **What:** Git integration built into Obsidian. Auto-commit, pull, push on interval
- **Why:** Automatic backups without needing to remember `/commit`. Set it to auto-commit every 30 minutes
- **Setup:** Initialize git in your vault first (`git init` in the vault folder). Then configure auto-backup interval

### Quick Add
- **What:** Quickly capture notes from a hotkey without navigating to a folder
- **Why:** Fast capture for ideas, tasks, meeting notes. Macro it to create a note from a template in the right folder

## Optional (Install Later)

### Kanban
- If you miss Notion's board views, this gives you kanban boards from markdown files

### Excalidraw
- Drawing and diagramming inside Obsidian. Good for architecture diagrams that stay in the vault

### Database Folder
- If you really miss Notion's database views, this recreates them in Obsidian. But try Dataview first.
