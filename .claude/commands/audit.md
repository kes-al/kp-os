## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Perform a vault health audit. Three modes:

- `/audit` — scan the whole vault, produce a report. No files modified.
- `/audit [path]` — scan only the targeted folder (e.g., `/audit work/[company]/projects/hackathon`, `/audit agent-output`). Same report format, scoped down.
- `/audit fix` — apply safe auto-fixes after a report has been reviewed. Can also be targeted: `/audit fix [path]`.

Always run `/audit` before `/audit fix`. Never run fix mode cold.

---

## Inputs

- `$ARGUMENTS` is parsed for:
  - `fix` keyword → enables fix mode
  - A folder path → scopes the audit to that folder (relative to vault root)
  - Both → e.g., `/audit fix agent-output`
  - Neither → full vault scan, report only

---

## Phase 1: Pre-flight

Check Obsidian CLI availability:

```bash
obsidian version
```

If CLI is unavailable, fall back to direct file I/O throughout. Log a callout at the top of the report:

> [!warning] Obsidian CLI unavailable — using direct file operations. Backlink counts may be approximate.

Read `/_meta/entities.md` to load the canonical entity registry. Build a lookup of:
- All entity names (primary and aliases)
- Their expected wikilink format (e.g., "Jordan Park" → `[[Jordan Park]]`, "MH" → `[[Meridian Health]]`)
- Their folder paths (for routing context)

This powers Scan 7 (unlinked entity mentions).

---

## Phase 2: Scope

Determine which files to audit:

**If a path argument was provided:**
- Scan only markdown files under `/vault/[path]/`
- Still run all scans, just scoped to that folder

**If no path argument:**
- Scan the whole vault

**Always exclude from ALL scans:**
- `/.obsidian/` — Obsidian config
- `/.claude/` — Claude Code config
- `/templates/` — templates
- `/_meta/` — meta files (except for entity registry cross-reference)
- Any `/files/` subfolder anywhere in the vault — binary reference materials, not vault notes
- `CLAUDE.md` and root-level config files
- `/intake/meetings/granola/` raw files (managed by plugin; processed/ is also excluded)

---

## Phase 3: Scans

Run all seven scans. Collect findings into structured lists. Do not modify any files during Phase 3.

### Scan 1 — Orphaned Notes

Definition: a markdown file with zero inbound wikilinks from any other vault note.

Additionally exclude from orphan detection (these are expected to have no inbound links):
- `/daily-notes/` — daily notes link out, aren't linked to
- `/agent-output/` — staging area
- `/intake/` — unprocessed by design

For each orphan found, classify it:
- **Stub** — fewer than 5 lines of body content
- **Isolated** — has content but no connections
- **Unknown** — can't determine without reading

Report format:
```
- [[Note Name]] — path/to/note.md — Classification — Last modified: YYYY-MM-DD
```

### Scan 2 — Stub Notes

Definition: a note with fewer than 5 lines of body content (excluding frontmatter).

Flag both stubs that are orphans and stubs that are linked.

Report format:
```
- [[Note Name]] — path/to/note.md — Body lines: N — Linked: yes/no
```

### Scan 3 — Broken Wikilinks

Definition: a `[[wikilink]]` that does not resolve to any existing file in the vault.

For each broken link, report:
- The file containing the broken link
- The broken link text
- Whether the target exists in `/_meta/entities.md` (rename/alias issue)

Report format:
```
- [[Note Name]] contains broken link [[Missing Target]] — entities.md match: yes/no
```

### Scan 4 — Frontmatter Issues

Check every markdown file in scope for frontmatter compliance.

Flag notes that:
- Have no frontmatter at all
- Are missing `title` field
- Are missing `type` field
- Are missing `date` field
- Have `status` values not in: `active`, `draft`, `review`, `archived`, `complete`
- Have `type` values not in: `note`, `meeting`, `decision`, `project`, `client`, `rfp`, `architecture`, `daily`, `resource`, `index`, `person`

Report format:
```
- path/to/note.md — Missing: [field list] — Invalid values: [field: value]
```

### Scan 5 — Stale Projects

Definition: a project hub note with `status: active` that has not been modified in 60+ days.

Scope: all `[Project Name].md` hub notes under `/work/`.

Report format:
```
- [[Project Name]] — client: [client] — Last modified: YYYY-MM-DD — [N] days stale
```

### Scan 6 — Intake Backlog

Count unprocessed files in `/intake/notes/`, `/intake/clipper/`, and `/intake/meetings/manual/`. Exclude `/intake/meetings/granola/` (plugin-managed) and `/intake/meetings/granola/processed/`.

Report format:
```
- intake/clipper/filename.md — Age: N days — Type: clip
```

### Scan 7 — Unlinked Entity Mentions

**This is the most important scan for content quality.**

Definition: plain-text mentions of registered entities that should be `[[wikilinks]]` but aren't.

For each file in scope, search the body text (not frontmatter, not code blocks, not existing wikilinks) for:
- Primary entity names from `/_meta/entities.md` (e.g., "Jordan Park", "Compliance Review", "Meridian Health")
- Aliases from `/_meta/entities.md` (e.g., "MH", "FE", "Sam")

**Match rules:**
- Case-insensitive matching for aliases, case-sensitive for primary names
- Only match whole words/phrases (not substrings)
- Skip text already inside `[[wikilinks]]`, `[[display|text]]`, code blocks, and frontmatter
- Skip the note's own title (a note about Jordan Park doesn't need to wikilink its own h1)
- Skip `/files/` subfolders entirely
- For aliases, map to the canonical entity: "MH" → suggest `[[Meridian Health]]` or `[[Meridian Health|MH]]`

**Prioritize by impact:**
- People names are highest priority (backlinks on person pages = interaction log)
- Client and project names are high priority (routing and graph connectivity)
- Technology names are medium priority
- Domain names are lower priority (more generic, higher false-positive risk)

Report format per file:
```
- path/to/note.md — N unlinked mentions:
  - "Jordan Park" (×3) → [[Jordan Park]]
  - "MH" (×2) → [[Meridian Health|MH]]
  - "Compliance Review" (×1) → [[Compliance Review]]
```

Group by file. Sort files by number of unlinked mentions (worst offenders first).

---

## Phase 4: Generate Report

Write the report to `/agent-output/vault-audit-YYYY-MM-DD.md`.

If a path scope was used, note it in the report title: `Vault Audit — YYYY-MM-DD — [path]`

Structure:

```markdown
---
title: Vault Audit YYYY-MM-DD
type: resource
date: YYYY-MM-DD
status: review
tags: [vault, audit, maintenance]
---

# Vault Audit — YYYY-MM-DD

> [!summary] Audit Summary
> **Scope:** [Full vault / path]
> Orphaned notes: N | Stubs: N | Broken links: N | Frontmatter issues: N
> Stale projects: N | Intake backlog: N | **Unlinked entities: N mentions across M files**
> Total issues: N | Recommended action: [none needed / review recommended / cleanup needed]

---

## Unlinked Entity Mentions (N mentions across M files)

[findings — grouped by file, worst offenders first]

### Suggested Actions
- Run `/audit fix` to auto-link N entity mentions across M files

---

## Frontmatter Issues (N)

[findings]

### Suggested Actions

---

## Orphaned Notes (N)

[findings]

### Suggested Actions

---

## Stub Notes (N)

[findings]

### Suggested Actions

---

## Broken Wikilinks (N)

[findings]

### Suggested Actions

---

## Stale Projects (N)

[findings]

### Suggested Actions

---

## Intake Backlog (N)

[findings]

### Suggested Actions

---

## Fix Mode Candidates

| File | Issue | Safe Fix |
|------|-------|----------|
| path/to/note.md | Unlinked "Jordan Park" ×3 | Replace with [[Jordan Park]] |
| path/to/note.md | Missing `date` field | Add `date` from file mod date |
| path/to/note.md | Missing frontmatter | Add minimal frontmatter |

Issues NOT in this table require manual review.
```

**Report ordering:** Put Unlinked Entity Mentions first — it's the highest-impact scan and the one most likely to trigger fix mode.

Print receipt to console:

```
✓ Vault audit complete — YYYY-MM-DD
  Scope:                 [Full vault / path]
  Unlinked entities:     N mentions across M files
  Frontmatter issues:    N
  Orphaned notes:        N
  Stub notes:            N
  Broken wikilinks:      N
  Stale projects:        N
  Intake backlog:        N
  ─────────────────────
  Total issues:          N
  Report: /agent-output/vault-audit-YYYY-MM-DD.md
  Run /audit fix to apply safe remediations.
```

---

## Phase 5: Fix Mode (`/audit fix` only)

Only runs when invoked with `fix`. Requires a report from Phase 4 to exist in `/agent-output/`.

Find the most recent `vault-audit-*.md` file. Read the "Fix Mode Candidates" table.

### Safe auto-fixes:

**Wikilink insertion (NEW — highest priority):**
- Replace plain-text entity mentions with proper `[[wikilinks]]`
- For primary names: `Jordan Park` → `[[Jordan Park]]`
- For aliases: `MH` → `[[Meridian Health|MH]]` (preserves the alias as display text)
- Only replace in body text — never in frontmatter, code blocks, or existing wikilinks
- Never replace inside a note's own h1 heading
- Process one file at a time. Read before writing. Verify each replacement is clean.

**Frontmatter fixes:**
- Add missing `date` field using file creation/modification date
- Add missing `type` field when unambiguously inferable from folder (e.g., `/people/` → `type: person`, `/meetings/` → `type: meeting`, `/daily-notes/` → `type: daily`)
- Add minimal frontmatter to files that have none (title from filename, type from folder, date from file date)
- Correct obvious `status` typos (e.g., `actve` → `active`)

**Intake cleanup:**
- Move Granola files to processed/ if already processed elsewhere

### Never auto-fix:
- Broken wikilinks (suggest only — incorrect rewrites corrupt the graph)
- Orphan deletion (always manual)
- Project status changes (stale ≠ dead)
- Daily note content
- Any replacement where context makes the entity reference ambiguous (e.g., "Mark" alone could be Chris Lang, Chris Lang, or generic)

### Fix execution:

If the scope is small (≤10 files), process sequentially and show each change.

If the scope is large (>10 files), use parallel agents — one per file or group of files. Each agent:
1. Reads the file
2. Applies all safe fixes for that file
3. Reports what changed

After all fixes, append a `## Fix Log` section to the audit report.

Print fix receipt:

```
✓ Fix mode complete — YYYY-MM-DD
  Entity mentions linked:   N across M files
  Frontmatter dates added:  N
  Frontmatter types added:  N
  Frontmatter created:      N
  Status typos corrected:   N
  ─────────────────────
  Total changes:            N
  Skipped (manual review):  N
  Fix log appended to: /agent-output/vault-audit-YYYY-MM-DD.md
```

---

## Rules

- Never modify `/daily-notes/` content (frontmatter fixes are OK, body content is never touched).
- Never delete files. Flag for deletion, never execute.
- Never rewrite EXISTING wikilinks. Only INSERT new ones where plain text exists.
- Never change `status` on project notes.
- Always read before writing any file touched in fix mode.
- Skip all `/files/` subfolders — these are binary reference areas, not vault notes.
- If unsure whether a fix is safe, skip it and add to "Manual Review Required" in the fix log.
- For ambiguous entity matches (e.g., "Mark" without surname), skip and flag rather than guess wrong.
