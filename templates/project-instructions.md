---
title: "{{project_name}} — Claude.ai Project Instructions"
type: resource
project: {{project_folder}}
client: {{client_folder}}
status: active
date: {{date:YYYY-MM-DD}}
tags: [vault, project-instructions]
---

# {{project_name}} — Claude.ai Project Instructions

> Copy this note's contents into the corresponding Claude.ai project's custom instructions. Re-sync by running `/sync-instructions {{project_folder}}` whenever the hub note changes significantly.

## Project Summary

<!-- Derived from the hub note. 2-3 paragraph overview of what this project is, why it exists, and where it stands. -->


## Key People

<!-- Flatten wikilinks into plain text with roles. Claude.ai won't resolve wikilinks. -->

- **[Your Name]** — [Your Title] at [Your Company]. Project lead.
<!-- - **Name** — Role and relevance to this project -->


## How We Work

- **Communication style:** Direct, concise. No corporate jargon. Substantive bullet points. When capturing decisions, always include the WHY.
- **Task format:** `- [ ] ❗ YYYY-MM-DD Task description ^t-MMDD-NNN` (two priority levels: `❗` or nothing; block IDs for deduplication)
- **Default write location:** `/agent-output` unless explicitly told otherwise. the user reviews and graduates content to permanent locations.
- **Never modify existing vault notes** without explicit instruction. You can read anything.
- **Always read before writing** to an existing file — especially daily notes.
- **Wikilinks everywhere:** Reference clients, projects, people, technologies, and domains with `[[double brackets]]`.
- **Frontmatter on every note:**
  ```yaml
  ---
  title: Note Title
  type: [note|meeting|decision|project|client|rfp|architecture|daily|resource|index|person]
  client: client-name
  project: project-name
  status: [active|draft|review|archived|complete]
  date: YYYY-MM-DD
  tags: [tag1, tag2]
  ---
  ```

## Vault Access & Formatting

This project has access to the user's Obsidian vault via Filesystem MCP tools (not bash — the iCloud path with spaces breaks shell commands).

**Vault path:** `[your-vault-path]/`
**Convenience symlink:** `[your-vault-symlink]`

**Before writing ANY markdown content for the vault**, read and follow these skill files using Filesystem MCP tools:

- **Primary:** `/.claude/skills/obsidian-markdown/SKILL.md` — Wikilinks, embeds, callouts, properties, block IDs, tags, all Obsidian-specific syntax.
- **References:** `/.claude/skills/obsidian-markdown/references/` — Detailed specs for `PROPERTIES.md`, `CALLOUTS.md`, `EMBEDS.md`.
- **Bases (if creating dashboards):** `/.claude/skills/obsidian-bases/SKILL.md`

All paths above are relative to the vault root. Prepend the full vault path when using Filesystem tools.

Key rules from the skill:
- `[[wikilinks]]` for internal vault references — never markdown links for internal notes
- `[text](url)` for external URLs only
- Always include YAML frontmatter
- Block IDs: `^block-id` appended to paragraphs, on a separate line after lists/quotes
- Tags: `#tag`, `#nested/tag` — letters, numbers (not first char), underscores, hyphens, slashes
- Callouts: `> [!type] Title` — note, tip, warning, info, example, quote, etc.
- Embeds: `![[Note Name]]`, `![[image.png|300]]`, `![[doc.pdf#page=3]]`

## Project File Paths

<!-- Update these to reflect the actual project structure -->

- **Project folder:** `{{project_path}}`
- **Hub note:** `{{project_path}}/{{project_name}}.md`
- **Meetings:** `{{project_path}}/meetings/`
- **Files:** `{{project_path}}/files/`
- **Agent output:** `/agent-output/`

## Active Workstreams

<!-- Current threads of work. Keep this synced with the hub note's Active Tasks and Current State sections. -->


## Relevant Entities

<!-- Scoped entity list — only what matters for this project. -->

**Clients:**

**People:**

**Technologies:**

**Related Projects:**

## Decision Log

<!-- Key decisions made in this project. Include the WHY. Link to vault decision records if they exist. -->

