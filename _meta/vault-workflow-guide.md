---
title: Vault Workflow Guide
type: resource
domain: pkm
status: active
date: 2026-02-27
updated: 2026-03-26
tags: [pkm, workflow, reference]
---

# When to Use What

Quick reference. Organized by moment, not by command.

---

## Session Start (automatic)

The **SessionStart hook** runs automatically when you open Claude Code in the vault. It loads today's daily note and open task summary into Claude's context. No action needed — Claude already knows your plan and outstanding work.

If no daily note exists, it prompts you to run `/startday`.

---

## Morning (5 min)

**`/startday`** — First thing. Creates today's daily note, pulls open tasks (deduplicated by block ID so nothing appears twice), builds your plan. Assigns IDs to any legacy tasks missing them. Outputs a receipt so you can gut-check the day at a glance. Don't start working until you've seen the plan.

If you need a deeper read on what's active across all clients and projects:
**`/context`** — Full vault briefing. Active clients, active projects, recent activity, open tasks. Use this Monday mornings or after time off.

---

## Before a Meeting or Focused Session

**`/context-load [target]`** — Load everything about a specific client, project, or topic. Run this before a client call, a project deep-dive, or an RFP session. Example: `/context-load acme-corp` or `/context-load commerce`.

---

## During the Day — Capturing Stuff

**`/capture [whatever you want to say]`** — The low-friction option. Speak naturally. It parses entities, creates tasks (with block IDs for tracking), logs context, and routes everything to today's daily note. Outputs a receipt showing what landed where. Use this between meetings, after a call, whenever something needs to get out of your head.

For meeting transcripts specifically:
**`/ingest-meeting [transcript or file path]`** — Accepts raw pasted text or a path to a note in `/intake/meetings/`. Restructures it, wikilinks everything, and routes to the right client/project meetings folder. Extracts action items (with block IDs) into today's daily note Suggested Tasks. Outputs a structured receipt.

After a block of back-to-backs:
**`/ingest-batch [today/yesterday/date]`** — Finds all unprocessed meetings in `/intake/meetings/` (Granola + manual), shows you the queue, and steps through each one with full processing. You can skip or stop mid-batch.

---

## Triage — Clearing the Inbox

Everything unprocessed lives in `/intake` (meetings, notes, web clips). Process it when you have time:

**`/triage`** — The nuclear option. Sweeps all of `/intake` — meetings, notes, and clips. Shows the full queue grouped by type, steps through each with the appropriate processing pipeline. Use at end of day or end of week to clear everything.

**`/triage-tasks`** — Batch triage of accumulated tasks. Reviews unpromoted suggested tasks (from meeting ingests) and optionally overdue active tasks. Groups by workstream (client/project) so you make related decisions together. For each task: promote to Active Tasks, mark done, cancel, delegate, reschedule, or defer. Supports `--quick` mode for fast promote/done/skip decisions. Use weekly or whenever the suggested task count gets high.

**`/process`** — Run on any single note (in `/intake/notes/` or anywhere in the vault). Wikilinks entities, fixes frontmatter, formats tasks, tags ideas, suggests where it should live. Great for a note you just finished writing raw.

**`/process-batch`** — Sweep `/intake/notes/` specifically. Same step-through-one-at-a-time flow as `/ingest-batch`.

---

## When You're Thinking

**`/ghost [question]`** — "How would I answer this?" Answers directly in the conversation based on your vault — past decisions, stated positions, communication style. Saves to a file only if substantial. Use for RFP questions, strategy prompts, or when someone asks you something and you want to think out loud against your own history.

**`/challenge [topic]`** — Stress-test an idea. Outputs the analysis directly, and if contradictions are found, suggests specific note updates to resolve them. Use when you're about to commit to a direction and want pushback.

---

## When You Want Discovery

**`/trace [topic]`** — Timeline of how a concept evolved across the vault. If the trace reveals significant evolution, suggests creating a summary note. Good for strategy retrospectives.

**`/connect [A] and [B]`** — Find hidden links between two topics. Suggests cross-links to hub notes if connections are actionable. Use when you suspect two areas of work have something in common but you haven't made it explicit.

**`/drift`** — What themes keep showing up across unrelated notes? Compares drift themes against active projects to flag alignment gaps. Offers to scaffold projects or create tasks for themes worth pursuing. Run monthly or when you're feeling restless.

**`/emerge`** — Are scattered ideas coalescing into something bigger? For ready clusters, offers to scaffold via `/new-project`. Use when you want to see if a project is trying to form itself from the bottom up.

**`/ideas`** — Full idea generation pass. Scans for unsolved problems, unexplored tech, knowledge gaps, things to write. Offers to create tasks, domain notes, or project scaffolds from top ideas. Use when you have an open Friday afternoon.

---

## End of Day (5 min)

**`/closeday`** — Summarizes what got done, surfaces carry-overs (with block IDs preserved for tracking), captures connections between the day's work. Scans for career evidence — noteworthy accomplishments get logged to `/domains/career/evidence-log.md`. Outputs a receipt with completion stats.

---

## End of Week

**`/weekly-review`** — Accomplishments, patterns, drift check (am I doing what I said matters?), next week priorities. Generates carry-forward tasks and offers to add them to next Monday's daily note.

**`/schedule`** — Day-by-day schedule suggestion based on active projects, due tasks, and meetings. Flags conflicts and overloaded days. Offers to create time-block tasks in daily notes.

---

## When You Add Something to the Vault

**`/new-initiative [name]`** — Scaffold a new internal initiative under `/work/[company]/initiatives/`. Initiatives are strategic themes with sub-projects — broader than a single project. Creates hub note with Vision, Strategy, Projects sections. Sub-projects are then added with `/new-project [initiative] [name]`.

**`/new-client [name]`** — Scaffold a new client folder with hub note, files, meetings, projects structure.

**`/new-project [client] [name]`** — Scaffold a new project under a client.

**`/new-domain [name]`** — Scaffold a knowledge domain: hub note + `/files` in `/domains/[name]/`. Adds to entity registry with aliases for routing. Can retrofit existing flat domains without touching existing content.

**`/new-code [path] [repo] [url]`** — Register a codebase under a project with symlink instructions.

**`/bridge [code-path]`** — Connect a code project's docs to the vault graph. Run this after symlinking a new code project to `/code/`.

**`/sync-instructions [project]`** — Re-derive `project-instructions.md` from the hub note. Flattens wikilinks for Claude.ai portability. Run after significant hub note changes.

---

## Maintenance (as needed)

**`/graduate`** — Scans last 14 days of daily notes for #idea tags and substantial observations. Routes directly to the correct domain/project folder when the home is obvious, falls back to `/agent-output/graduated/` when unclear. Outputs a receipt. Run weekly or when your Ideas sections are getting long.

**`/relink [file]`** — Re-scan a note and add missing wikilinks for any entities it references. Use after editing a note manually or importing content from outside the vault.

**`/audit [path]`** — Vault health scan across seven dimensions: **unlinked entity mentions** (highest priority), orphaned notes, stubs, broken wikilinks, frontmatter issues, stale projects, intake backlog. Folder-targetable (e.g., `/audit work/[company]/projects/hackathon`). Writes a report to `/agent-output/`. Follow up with `/audit fix` to apply safe auto-fixes — inserts `[[wikilinks]]` for plain-text entity mentions, fixes missing frontmatter. Run monthly or when the vault feels messy.

**`/commit`** — Stage, commit, push the vault to git. Run at end of day or after significant changes.
