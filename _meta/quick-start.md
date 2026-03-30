---
title: Vault Quick Start Guide
type: resource
date: 2026-02-25
updated: 2026-03-26
tags: [vault, reference]
---

# Vault Quick Start Guide

## Day 1 Setup

### 1. Open in Obsidian
- Open Obsidian
- Select "Open folder as vault"
- Point it to this `/vault` folder

### 2. Configure Settings (BEFORE installing plugins)
Do settings first, plugins second. Installing everything at once can corrupt the cache.

- Settings → Files & Links:
  - Default location for new notes: "In the folder specified below" → set to `agent-output`
  - Default location for attachments: "In the folder specified below" → set to `attachments`
  - Automatically update internal links: **ON**
  - Use [[Wikilinks]]: **ON**
- Settings → Files & Links → Excluded files (add ALL of these):
  - `**/files` — binary reference files in client folders (PPTs, PDFs, images, videos)
  - `node_modules`
  - `.git`
  - `.next`
  - `dist`
  - `build`
  - `.venv`
  - `__pycache__`

### 3. Configure Daily Notes (Core Plugin)
- Settings → Core plugins → Daily notes → enable it
- Date format: `YYYY-MM-DD`
- New file location: `daily-notes`
- Template file location: `templates/daily-note`

### 4. Install Community Plugins (one at a time)
- Go to Settings → Community Plugins → Turn off Safe Mode
- Install **Templater** first → set template folder to `templates` → enable "Trigger Templater on new file creation" → confirm vault still works
- Install **Calendar** → confirm vault still works
- Stop here for day one. Add Tasks, Dataview, and others later as needed
- See `/_meta/recommended-plugins.md` for the full list

### 5. Set Up Code Directory
Do NOT symlink entire code repositories — Obsidian traverses all subdirectories during indexing (including node_modules), which pollutes the graph with thousands of LICENSE.md and README.md files from dependencies. Exclusion patterns hide them from search but don't prevent graph pollution.

**Always symlink only the /docs folder** (or whichever folder contains the markdown you care about).

Create a `/code` folder inside the vault organized by context:
```
/vault/code
  /personal
    /project-name → symlink to repo's /docs folder
  /[company]
    /clients
      /client-name
        /project-name → symlink to repo's /docs folder
    /internal
      /domain
        /project-name → symlink to repo's /docs folder
```

To add a project:
```bash
# Personal project
mkdir -p [VAULT_PATH]/code/personal
ln -s /path/to/actual/repo/docs [VAULT_PATH]/code/personal/project-name

# Client project
mkdir -p [VAULT_PATH]/code/[company]/clients/client-name
ln -s /path/to/actual/repo/docs [VAULT_PATH]/code/[company]/clients/client-name/project-name

# internal project
mkdir -p [VAULT_PATH]/code/[company]/internal/domain
ln -s /path/to/actual/repo/docs [VAULT_PATH]/code/[company]/internal/domain/project-name
```

Add/remove symlinks as projects become active or inactive. Only symlink projects you're actively working on (typically 5-10). After adding a symlink, run `/bridge` to create a bridge note connecting the code docs to the vault graph.

### 6. Initialize Git
```bash
cd [VAULT_PATH]
git init
git add .
git commit -m "Initial vault setup"
```
Add a remote if you want to push to GitHub/GitLab.

### 7. iCloud Setup (for syncing between machines)
Move the vault folder to the Obsidian iCloud container (syncs natively across macOS and iOS):
```bash
mv [VAULT_PATH] ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault
```
Then create a symlink back for convenience:
```bash
ln -s ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault [VAULT_PATH]
```
On your other machines with Obsidian installed, the vault will appear in the Obsidian iCloud container automatically.
Set "Keep Downloaded" on both machines: right-click the vault folder in Finder → "Keep Downloaded"

Note: Code symlinks are machine-specific. The `/code` folder syncs via iCloud but the symlinks inside it point to local paths. You'll need to create the symlinks on each machine pointing to that machine's local code directory.

## Troubleshooting

### Obsidian stuck on "Loading cache" or "Indexing vault"
This is almost always caused by Obsidian trying to traverse a massive directory tree (like a full code repo with node_modules). The fix: symlink only `/docs` folders, never entire repos.

1. Force quit Obsidian
2. Remove the offending symlink: `rm [VAULT_PATH]/code/[project]`
3. Re-add it pointing to only the docs folder: `ln -s /path/to/repo/docs [VAULT_PATH]/code/[project]`
4. If still stuck, clear the global Obsidian cache:
   ```bash
   rm -rf ~/Library/Application\ Support/obsidian
   rm -rf ~/Library/Caches/md.obsidian
   ```
4. Reopen Obsidian — it will reload your vault settings from `.obsidian` inside the vault
5. Re-add symlinks one at a time, restarting Obsidian after each to confirm

Do NOT delete the `.obsidian` folder inside the vault unless absolutely necessary — that holds all your settings and plugin configs.

## Day 1 Workflow

1. Open your vault in Obsidian
2. Run `/startday` in Claude Code, or click today's date in the Calendar sidebar to create a daily note from template
3. Write what you're working on today
4. When you reference a client or project, type `[[` and start typing — Obsidian autocompletes
5. That's it. You're building the graph.

## Vault Top-Level Structure

```
/vault
  /work          ← Clients and internal projects
  /people        ← Person pages by org ([company]/, clients/, personal/)
  /domains       ← All knowledge areas (professional + personal)
  /intake        ← Triage point: meetings, notes, clips
  /daily-notes   ← Daily journal
  /templates     ← Note templates
  /agent-output  ← Claude writes here
  /attachments   ← Pasted images and media
  /_meta         ← MOCs, entity registry, docs
  /code          ← Symlinks to active code projects
  /.claude       ← Claude Code slash commands
```

## Working with Claude

### In Claude.ai (this interface)
- When we're working on something and you want to save it, say "save this to Obsidian"
- I'll write a properly formatted note with frontmatter and wikilinks
- I'll write it to your filesystem via the tools available

### In Claude Code
- Point Claude Code at the vault: it reads CLAUDE.md first, then operates accordingly
- Slash commands live in `/.claude/commands/` and are available as `/command-name`
- Start with `/context` at the beginning of each session

## The Habit

The vault only works if you write in it. The minimum viable habit is:

1. **Morning:** Run `/startday` — creates today's note, pulls open tasks from previous days, generates a prioritized plan
2. **During work:** Save important things as they happen — meeting notes, decisions, ideas. Add new tasks to the Active Tasks section.
3. **End of day:** Run `/closeday` — summarizes what got done, surfaces connections, formats carry-overs

`/startday` and `/closeday` are bookends. Everything else builds on top of this. The daily note is the entry point.
