---
title: Claude.ai Project Setup
type: resource
date: 2026-03-30
tags: [guide, reference]
---

# Claude.ai Project Setup

How to set up a Claude.ai project that connects to the Obsidian vault with persistent context.

---

## 1. When to Create a Claude.ai Project

Create one for any project with **ongoing deep work** where you want persistent context across sessions -- strategy docs, architecture analysis, writing, client planning. Not for one-off questions or quick lookups. Those are fine in a standalone Claude chat or Claude Code.

## 2. Generate project-instructions.md

The `/new-project` command auto-creates this file when scaffolding a new project. If it doesn't exist yet or has gone stale:

1. Open Claude Code in the vault
2. Run `/sync-instructions [project]` (accepts project name, alias, or folder name)
3. The command reads the hub note and re-derives all sections of `project-instructions.md`
4. It flattens wikilinks to plain text since Claude.ai cannot resolve them

> [!note] Location
> The file lives next to the project hub note:
> `work/clients/[client]/projects/[project]/project-instructions.md` (client projects)
> `work/[company]/projects/[project]/project-instructions.md` (internal)

## 3. Create the Claude.ai Project

1. Go to [claude.ai](https://claude.ai) and sign in
2. Click **Projects** in the left sidebar
3. Click **New Project**
4. Name it to match the vault project name exactly (e.g., "Commerce", "Acme RFP", "Field Engineering")
5. Open **Custom Instructions**
6. Paste the **entire contents** of `project-instructions.md` into the custom instructions field
7. Save

> [!tip] What the instructions include
> The template already contains a directive telling Claude to read `/.claude/skills/obsidian-markdown/SKILL.md` via Filesystem MCP before writing any vault content. You do not need to add this separately.

## 4. Set Up MCP Filesystem Tools

> [!warning] Desktop app required
> MCP tools (including Filesystem) only work in the **Claude desktop app** (Mac/Windows). They do NOT work on the claude.ai website. You must use the downloadable app for vault access.

1. In the Claude desktop app, go to **Settings** → **Developer** → **MCP Servers**
2. Add a **Filesystem MCP server** with this path:
   ```
   ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault/
   ```
3. Save and restart Claude if needed

> [!warning] Use Filesystem MCP, not bash
> The iCloud container path contains spaces (`Mobile Documents`, `iCloud~md~obsidian`). Shell commands break on these spaces. Always use Filesystem MCP tools (read_file, write_file, list_directory) for vault access.

A convenience symlink also exists at `[VAULT_SYMLINK]` but Filesystem MCP with the full path is the reliable approach.

> [!tip] If using claude.ai web instead
> Without MCP, Claude can't read/write vault files directly. You'll need to paste content manually into conversations and copy outputs back to the vault. The `project-instructions.md` custom instructions still work — Claude just can't access files autonomously.

## 5. What Goes Where: Claude.ai vs Claude Code

| | Claude.ai Project | Claude Code |
|---|---|---|
| **Purpose** | Deep work sessions, writing, analysis, strategy docs | Vault management, commands, meeting ingestion, task management, commits |
| **Context source** | `project-instructions.md` (pasted into custom instructions) | `CLAUDE.md` (auto-loaded from vault root) |
| **File access** | Filesystem MCP tools | Direct file system |
| **Best for** | Thinking through a problem, drafting deliverables, research | Running `/startday`, `/ingest-meeting`, `/capture`, `/commit`, any slash command |
| **Writes to** | `/agent-output` by default | `/agent-output` by default |

They complement each other. Claude.ai does the thinking; Claude Code does the plumbing.

## 6. Keep Instructions in Sync

When the hub note changes significantly -- new team members, strategy shift, new workstreams, status change:

1. Run `/sync-instructions [project]` in Claude Code
2. Open the regenerated `project-instructions.md` in the vault
3. Copy the full contents
4. Go to the Claude.ai project settings
5. Replace the custom instructions with the new version
6. Save

> [!note] What sync does
> The command reads the current hub note, flattens wikilinks to plain text, updates the entity list, refreshes active workstreams and file paths. The result is a self-contained briefing with no unresolved vault references.

## 7. Tips

- **Default write location is `/agent-output`.** Always have Claude.ai write there unless you explicitly say otherwise. Review and graduate content to permanent locations.
- **Meeting notes from Claude.ai** should be saved to `/agent-output/meetings/`, then ingested via Claude Code using `/ingest-meeting` or `/process`.
- **The vault-level project** (`/_meta/project-instructions.md`) is for vault-wide work, not a specific client or internal project. It lives in Claude.ai as the "Vault" project.
- **One project per workstream.** Don't try to cram multiple unrelated projects into one Claude.ai project. The context will get noisy.
- **Read before writing.** The instructions tell Claude.ai to read before writing to any existing file, but reinforce this in conversation if you see it about to overwrite.
