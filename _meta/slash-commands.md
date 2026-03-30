---
title: Slash Commands Reference
type: resource
date: 2026-03-09
updated: 2026-03-26
tags: [vault, reference, commands]
---
      
# Slash Commands Reference

All Claude Code slash commands in `/.claude/commands/`. This file is the canonical reference — if it disagrees with the command file, the command file wins.

For **when to use each command** (organized by workflow moment, not by command name), see [[vault-workflow-guide|Vault Workflow Guide]].

---

## Daily Bookends

### /startday
Create today's daily note, pull open/overdue tasks from the last 5 daily notes, generate a prioritized plan (must-do, should-do, could-do). **Deduplicates tasks by block ID** — same `^t-MMDD-NNN` across multiple daily notes = one task (keeps most recent instance). Assigns block IDs to legacy tasks that don't have them. Outputs a receipt showing task counts, plan breakdown, and heaviest area. Warns if overdue tasks exceed 5.

### /closeday
Find unclosed daily notes, generate end-of-day summary (accomplishments, carry-overs, connections). **Preserves block IDs** on carry-over tasks — same task keeps its ID across days. Legacy tasks without IDs get assigned when carrying forward. Runs a **career evidence capture** pass — scans the day's work for review-worthy items and appends to `/domains/career/evidence-log.md`. Outputs a receipt with completion stats and evidence logged.

---

## Capture

### /capture [natural language]
Route natural language input to the right places. Parses entities against the registry, creates inline tasks (with block IDs), tags ideas, logs observations. Always writes to today's daily note. Suggests secondary routing to client/project/person notes but asks before writing. Outputs a receipt showing what was written and where.

### /ingest-meeting [transcript or file path]
Process a meeting into a structured note. Accepts raw pasted text, a file path to a Granola-synced note (e.g., `/intake/meetings/granola/2026-02-26-standup.md`), or a meeting name to search in `/intake/meetings/`. Three-tier routing: (1) entity match + folder exists → route normally, (2) entity match + no folder → auto-scaffold client folder then route, (3) no entity match → save to `/agent-output/meetings/` and ask. Carries Granola identifiers as `source_id`/`source_url` (NOT `granola_id`/`granola_url` — the plugin overwrites files with those field names). Includes an Attendees section with wikilinks and a placeholder task to confirm names. Extracts action items (with block IDs) into today's daily note Suggested Tasks section. After processing, moves the raw source file to `/intake/meetings/granola/processed/`. Outputs a structured receipt.

### /ingest-batch [date filter]
Process multiple unprocessed meetings in sequence. Scans `/intake/meetings/` (both granola and manual) for notes without a processed counterpart elsewhere in the vault. Presents a numbered queue with detected clients/projects. Steps through one at a time with full `/ingest-meeting` processing, pausing between each for approval. Supports skip/stop controls mid-batch. Outputs per-meeting receipts and a final batch summary. Default filter is today; also accepts "yesterday", "this week", or a specific date.

---

## Triage

### /triage [filter]
Sweep the entire `/intake` folder — meetings, notes, and clips. Shows a queue grouped by type with detected entities for each item. Steps through one at a time using the appropriate pipeline: meetings get `/ingest-meeting`, notes get `/process`, clips get light processing (frontmatter, wikilinks, domain tagging). Supports filtering by date or type. Pause between items with skip/stop controls. Outputs per-item receipts and a batch summary. The "clear my inbox" command.

### /triage-tasks [filter]
Batch triage of accumulated tasks. Two phases: (1) unpromoted suggested tasks from daily notes, grouped by workstream, (2) optional overdue active task review. For each task: promote, done, cancel, delegate, reschedule, or defer. Groups by client/project for context-aware batch decisions. Supports `--quick` mode (promote/done/skip only), date ranges, and workstream filters. Shows overview → one group at a time → mini-receipts → final accounting.

### /process [note]
Make a note vault-native. Wikilinks all entities against the registry (with proper aliases), adds or fixes frontmatter, formats raw tasks into proper inline format with dates and priorities, tags #idea-worthy lines, and checks if the note is in the right location. Shows a full preview before applying — you can accept all, cancel, or pick specific changes. Run this on any note you've been writing in. If no path is given, processes the current file.

### /process-batch [date filter]
Process multiple raw notes from `/intake/notes/` in sequence. Finds unprocessed notes, presents a queue with detected entities, steps through each with full `/process` treatment plus routing suggestion. Notes that get routed leave `/intake`. Default processes all; accepts date filters.

---

## Context Loading

### /context
Full vault briefing. Active clients, active projects, recent daily note activity, open tasks, flags. Morning context load or returning-from-time-off briefing.

Note: The SessionStart hook already provides baseline context (today's daily note + task summary) automatically. Use `/context` when you need the full picture beyond today.

### /context-load [target]
Focused context for a specific client, project, or topic. Reads hub note, folder contents, recent meetings, related code docs, active tasks, and last 30 days of daily note mentions.

---

## Thinking & Analysis

### /ghost [question]
Answer a question in the user's voice based on vault history — past decisions, stated positions, communication patterns. **Outputs directly in the conversation.** Only saves to `/agent-output/ghost/` if the response is substantial (10+ lines).

### /challenge [topic]
Stress-test thinking on a topic. Finds stated positions, identifies assumptions, surfaces contradictions, generates counter-arguments. **Outputs directly in the conversation.** If contradictions are found, suggests specific note updates to resolve them. Saves to `/agent-output/challenges/` as archival.

---

## Discovery

### /trace [topic]
Timeline of how a concept evolved across the vault. First appearance, evolution, current state, connections. **Outputs directly in the conversation.** If the trace reveals significant evolution, suggests creating a summary note in the relevant domain. Saves to `/agent-output/traces/` as archival.

### /connect [A] and [B]
Find connections between two topics — direct links, indirect paths, shared context, potential synergies. **Outputs directly in the conversation.** Suggests cross-links to hub notes if connections are actionable. Saves to `/agent-output/connections/` as archival.

### /drift
Surface recurring themes across unrelated notes. What are you unconsciously circling? **Outputs directly in the conversation.** Compares drift themes against active projects to flag alignment gaps. Offers to scaffold projects or create tasks for themes worth pursuing. Saves to `/agent-output/drift/` as archival.

### /emerge
Identify clusters of related ideas coalescing into something bigger than individual notes. Assess project-readiness. **Outputs directly in the conversation.** For ready clusters, offers to scaffold via `/new-project`. For emerging clusters, offers to add investigation tasks. Saves to `/agent-output/emerge/` as archival.

### /ideas
Full idea generation pass. Unsolved problems, unexplored tech, knowledge gaps, things to write, process improvements. **Outputs directly in the conversation.** Offers to create tasks, domain notes, or project scaffolds from top ideas. Saves to `/agent-output/ideas/` as archival.

---

## Review

### /weekly-review
Scan past 7 daily notes. Accomplishments, patterns, drift check (am I doing what I said matters?), next week priorities, graduation candidates. Generates carry-forward tasks and offers to add them to next Monday's daily note. Outputs a receipt with summary stats. Saves to `/agent-output/reviews/`.

### /schedule
Day-by-day schedule suggestion based on active projects, due tasks, and meetings. Flags conflicts: overloaded days, unallocated project time, no thinking time protected. Offers to create time-block tasks in daily notes if approved.

---

## Scaffolding

### /new-initiative [name]
Scaffold a new internal initiative under `/work/[company]/initiatives/`. Initiatives are broad strategic themes with multiple sub-projects (Commerce, Health Platform, AI Strategy). Creates hub note (`type: initiative`) with Vision, Strategy, Projects (Dataview query), Team, Key Decisions sections, plus `/files`, `/meetings`, `/projects` directories. Updates entity registry and CLAUDE.md. Sub-projects are then scaffolded with `/new-project [initiative] [name]`.

### /new-client [name]
Create client folder structure: hub note, `/files`, `/meetings`, `/projects`. Add to entity registry and Clients index.

### /new-project [client] [name]
Create project under a client: project context note, `/files`, `/meetings`. Add to entity registry and client hub note.

### /new-domain [name]
Scaffold a knowledge domain or retrofit an existing one with structure. Creates hub note + `/files` in `/domains/[name]/`. Adds to entity registry with aliases for routing. Synthesis notes accumulate in the root over time via `/capture`, `/ghost`, research sessions. Can be run against existing flat domains to add the hub note without touching existing content.

### /new-code [project-path] [repo-name] [repo-url]
Register a codebase under a project. Creates a code note with repo URL, stack, symlink path. Runs bridge analysis if symlink exists, otherwise provides the symlink command. Updates project hub note.

### /bridge [code-path]
Create a bridge note connecting a symlinked code project's docs to the vault graph. Reads all markdown in the code project, generates a summary with wikilinks, saves to the appropriate location, updates relevant hub notes.

### /sync-instructions [project]
Re-derive a project's `project-instructions.md` from its current hub note. Resolves the project from the entity registry, reads the hub note fresh, and regenerates the portable Claude.ai briefing. Flattens all wikilinks to plain text (Claude.ai can't resolve them). Preserves static sections (How We Work, Vault Access & Formatting) from the existing file. Reports which sections were derived vs. empty. Full overwrite — this is a derived artifact, not incrementally edited. Run this after significant hub note changes, then copy the output into the corresponding Claude.ai project.

---

## Maintenance

### /graduate
Scan last 14 days of daily notes for #idea tags, substantial observations, recurring themes. Promote to standalone notes. **Routes directly to the correct domain/project folder** when the home is obvious. Falls back to `/agent-output/graduated/` only when unclear. Outputs a receipt showing what was promoted and where.

### /relink [file]
Re-scan a note against the entity registry and add missing `[[wikilinks]]`. Shows changes before applying.

### /audit [path]
Vault health audit across seven dimensions: **unlinked entity mentions** (new — highest priority), orphaned notes, stub notes, broken wikilinks, frontmatter issues, stale projects, and intake backlog. Folder-targetable and three modes:
- `/audit` — full vault scan, writes report to `/agent-output/vault-audit-YYYY-MM-DD.md`. No files modified.
- `/audit [path]` — scoped scan (e.g., `/audit agent-output`, `/audit work/[company]/projects/hackathon`).
- `/audit fix [path]` — reads the most recent audit report and applies safe auto-fixes. Key fix: **inserts `[[wikilinks]]` for plain-text entity mentions** using the entity registry. Also fixes missing frontmatter. Never rewrites existing wikilinks, never deletes files, never touches daily note content. Uses parallel agents for large scopes (>10 files).

### /commit
Stage all vault changes, generate a descriptive commit message, commit and push.

---

## Deprecated

### /today
Replaced by `/startday`. Redirects automatically.
