## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scaffold a new internal initiative. Initiatives are broad strategic themes with multiple sub-projects — broader than a single project. Examples: Commerce, Health Platform, AI Strategy.

`$ARGUMENTS` should be in the format: `"Initiative Name" [optional: alias1, alias2]`

Examples:
- `/new-initiative "Commerce"`
- `/new-initiative "Health Platform" Health, Life Sciences, HLS`
- `/new-initiative "AI Strategy" ai-at-tag, ai-strategy`

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to direct file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Parse Arguments

Extract the initiative name and optional aliases from `$ARGUMENTS`.

If no arguments provided, ask for the initiative name.

## Step 2: Generate Folder Name

Convert the initiative name to lowercase-hyphenated format:
- "Health Platform" → `health`
- "AI Strategy" → `ai-at-tag`
- "Commerce" → `commerce`

Strip common prefixes like "TAG" unless they're essential to the meaning.

## Step 3: Check for Conflicts

Check if `work/[company]/initiatives/[folder]` already exists. If so, stop and report:

> [!warning] Initiative already exists
> `work/[company]/initiatives/[folder]/` already exists. Use `/context-load [name]` to review the existing initiative.

## Step 4: Scaffold Folder Structure

Create:

```
work/[company]/initiatives/[folder]/
  [Initiative Name].md    ← Initiative hub note
  /files                  ← Binary reference files
  /meetings               ← Initiative-level meetings
  /projects               ← Sub-projects (scaffold with /new-project)
```

## Step 5: Generate Initiative Hub Note

Use the initiative template pattern (matching [[AI Strategy]]):

```yaml
---
title: [Initiative Name]
type: initiative
status: active
owner: "[[the vault owner]]"
stakeholders: []
date: YYYY-MM-DD
tags: [initiative]
---
```

Body sections:

```markdown
# [Initiative Name]

## Vision

<!-- What is this initiative about? What's the strategic narrative? One paragraph. -->

## Strategy

<!-- Current strategic approach. Updated as the initiative evolves. -->

## Projects

\```dataview
TABLE status AS "Status", date AS "Date"
FROM ""
WHERE type = "project" AND contains(file.outlinks, this.file.link)
SORT date DESC
\```

### Confirmed

<!-- - [[Project Name]] — One-line description. -->

### Candidates

<!-- - [[Project Name]] — Why it might fit under this initiative. -->

## Team

<!-- Key people involved. Use wikilinks: [[Person Name]] — Role/context -->

## Artifacts

%% Link strategy decks, proposals, executive presentations here as they're created. %%

## Key Decisions

%% Running log — format: **Decision** (YYYY-MM-DD) — Context and rationale. WHY: reason. %%

## Status & Timeline

- **Current phase:**
- **Next milestone:**
- **Target:**
```

## Step 6: Update Entity Registry

Read `/_meta/entities.md`. Add to the `## Initiatives` table:

```
| [[Initiative Name]] | work/[company]/initiatives/[folder] | aliases |
```

## Step 7: Update CLAUDE.md

Add to the Vault Structure section under `/initiatives/`:

```
/[folder]/             — [Brief description]
```

Add to the Entity Registry Reference section under `**Initiatives (TAG):**`.

## Step 8: Add Kick-Off Task

Add to today's daily note `## Active Tasks`:

```
- [ ] YYYY-MM-DD Define vision and strategy for [[Initiative Name]] initiative ^t-MMDD-NNN
```

## Step 9: Output Receipt

```markdown
> [!success] Initiative Scaffolded
> **Initiative:** [[Initiative Name]]
> **Location:** `work/[company]/initiatives/[folder]/`
> **Hub note:** Created with Vision, Strategy, Projects, Team, Key Decisions sections
> **Entity registry:** Updated
> **CLAUDE.md:** Updated
> **Next steps:**
> - Fill in the Vision section
> - Add sub-projects with `/new-project [initiative] "Project Name"`
> - Add stakeholders to frontmatter
```

## Rules

1. **Initiatives live under `/work/[company]/initiatives/`.** Never create them elsewhere.
2. **Sub-projects are scaffolded separately** with `/new-project [initiative] "Project Name"`. Don't scaffold sub-projects during initiative creation.
3. **The Dataview query in the hub note auto-links child projects** that reference this initiative in their outlinks. No manual linking needed.
4. **Always update the entity registry** — it's the single source of truth for path resolution.
5. **Hub note uses `type: initiative`**, not `type: project`. This distinguishes initiatives from projects in Bases queries and Dataview.


ARGUMENTS: $ARGUMENTS
