## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Batch triage of accumulated tasks. Two sources: unpromoted suggested tasks from daily notes and overdue active tasks. Group by workstream, decide in batches, write back immediately.

If `$ARGUMENTS` is provided, use it as a filter:
- `suggested` or `suggested-only` → only suggested tasks (phase 1)
- `overdue` or `active` → only overdue active tasks (phase 2)
- `--quick` → simplified decisions: promote/done/skip only (no cancel/delegate/reschedule)
- A date range (`mar 17-27`, `this week`, `last 2 weeks`) → only tasks from that timeframe
- A workstream filter (`compliance-engine`, `qc-tool`) → only that workstream group

No arguments = full triage (suggested tasks first, then offer overdue review).

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to direct file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Determine Today

Follow CLAUDE.md rule 6: today is the most recent daily note with an empty `## End of Day` section. All promoted tasks get written to this note.

Read today's daily note and parse its `## Tasks` section — you'll need the existing block IDs for deduplication.

---

## Step 2: Collect Suggested Tasks

Scan daily notes backward from today (up to 30 days). For each note with a `## Suggested Tasks` section:

1. Read the section.
2. Parse inline tasks (lines matching `- [ ]`). Capture: task text, block ID (`^t-MMDD-NNN`), due date, all `[[wikilinks]]`.
3. For "carried from" references (e.g., `*Carried from [[2026-03-17]] — 33 unpromoted*`), follow the link and read that note's Suggested Tasks too. Track visited notes to avoid loops.
4. Record the source meeting (from `*From [[meeting-note]]]*:*` headers above each task group) and source date.

**Deduplication:**
- Group by block ID. If the same ID appears in multiple notes' Suggested Tasks, keep only one instance (prefer the one with the richest description).
- **Exclude** any task whose block ID already appears in today's Tasks — it was already promoted.
- **Exclude** checked tasks (`- [x]`) and struck-through tasks (`~~`).

---

## Step 3: Collect Overdue Tasks (if not `suggested-only`)

Read today's `## Tasks` > `### Work`. Collect all unchecked tasks that are past due. These are candidates for phase 2.

---

## Step 4: Group and Sort Suggested Tasks

Extract the primary workstream from each task's wikilinks. Priority for grouping:
1. **Project** entities (`[[Compliance Review]]`, `[[Quality Tool]]`, `[[Field Engineering]]`)
2. **Client** entities (`[[Meridian Health]]`, `[[Redwood Co]]`)
3. **People** entities (`[[Alex Rivera]]`, `[[Jordan Park]]`)
4. **Domain** entities (`[[Finance]]`, `[[Career]]`)

If a task has multiple entities, prefer project > client > people > domain. A task mentioning `[[Compliance Review]] [[Meridian Health]]` groups under "Compliance Review."

**Sort groups** by number of tasks (descending — biggest clusters first).
**Within each group**, sort tasks by source date (newest first — recent meetings are more actionable).

**Staleness indicator:** Tasks older than 14 days get an age label: `(18 days old)`.

**Ungrouped tasks** (no entity wikilinks) go in a "General / Other" bucket at the end.

---

## Step 5: Present Overview

Show a summary before diving into groups:

```
> [!info] Task Triage
> **Suggested tasks found:** N (across M daily notes, date range)
> **Already promoted (skipped):** N (matched block IDs in Tasks)
> **To review:** N
>
> **By workstream:**
> 1. Compliance Review / Meridian Health — N tasks (N meetings)
> 2. Quality Tool / Pinnacle Tech — N tasks (N meetings)
> 3. Field Engineering — N tasks (N meetings)
> 4. Redwood Co — N tasks (N meetings)
> 5. Alex Rivera (1:1s) — N tasks (N meetings)
> ...
> 10. General / Other — N tasks
>
> Start triage? (y / pick [numbers] / skip [group] / stop)
```

**Controls:**
- **y** — start with group 1, proceed through all
- **pick 1 3 5** — only triage selected groups
- **skip [name]** — skip a named group
- **stop** — exit

---

## Step 6: Triage Each Group

For each group, present tasks with source meeting context:

```
---
### Group 1/N: Compliance Review / Meridian Health (N tasks)

*From [[2026-03-26 Meridian Health Regulatory Meeting]] (Mar 26):*
  1. [ ] 2026-03-28 Share deck with Jordan and Quinn ^t-0326-060
  2. [ ] 2026-03-31 Schedule deep dive with Morgan Liu ^t-0326-061
  3. [ ] 2026-04-07 Begin assessment phase ^t-0326-063 (4 days old)

*From [[2026-03-19 Meridian Health Demo and Presentation]] (Mar 19):*
  4. [ ] 2026-03-20 Send updated slide deck ^t-0319-050 (18 days old)
  5. [ ] 2026-03-23 Follow-up call with Morgan ^t-0323-031 (14 days old)

---
**Decisions:** For each task number, enter an action:

- **p** (promote) → move to Tasks > Work today
- **d** (done) → mark complete in source note
- **x** (cancel) → strikethrough in source note
- **w [person]** (waiting/delegate) → note who owns it
- **r [date]** (reschedule) → new date, then promote
- **-** (defer) → leave as-is, review next time

**Bulk syntax:** `p 1-2 x 4-5 d 3 - rest`
**"rest" shorthand:** applies the last-used action to all remaining unaddressed tasks.

Example: `p 1-2 r3 2026-04-14 x 4 d 5 - rest`
```

**Quick mode** (if `--quick`): Only `p` (promote), `d` (done), and `-` (skip/defer). No cancel, delegate, or reschedule options shown.

---

## Step 7: Apply Decisions

After receiving decisions for a group, apply immediately:

### Promote (p)
Append to today's daily note `## Tasks` > `### Work`. Tasks are a flat list sorted by priority (❗ first) then date.

Preserve exact task text including block ID and all wikilinks.

### Done (d)
In the **source** daily note's `## Suggested Tasks` section, find the line by block ID and change `- [ ]` to `- [x]`. Append ` ✅` with today's date.

### Cancel (x)
In the **source** daily note's `## Suggested Tasks` section, find the line by block ID and wrap the task description in `~~strikethrough~~`.

### Waiting/Delegate (w)
If the user says "not mine" or names an owner:
- Append `— waiting on [[Person]]` to the task
- Promote to today's Tasks > Work (so it's tracked as a dependency)

If the user says "delegated, don't track":
- Mark in source note with `— delegated to [[Person]]`
- Do NOT add to Tasks

### Reschedule (r)
Update the due date in the task text. Promote to today's Tasks > Work with the new date.

### Defer (-)
No action. Task stays in source daily note's Suggested Tasks. Will appear again next time `/triage-tasks` is run.

### Block ID rules
- **Preserve** original block IDs through all operations. Never change an ID during triage.
- Tasks without block IDs (legacy): assign a new one using today's date and the next available NNN.

### Clearing completed groups
After triage, if ALL tasks in a source daily note's Suggested Tasks meeting group are resolved (done/cancelled/promoted), replace the individual task list with: `*All N tasks triaged on [[YYYY-MM-DD]].*`

If only some are resolved, leave the remaining ones in place.

---

## Step 8: Mini-Receipt After Each Group

```
> [!done] Compliance Review / Meridian Health — N tasks triaged
> Promoted: N | Done: N | Cancelled: N | Waiting: N | Rescheduled: N | Deferred: N
>
> Next: Quality Tool / Pinnacle Tech (N tasks) — Continue? (y/skip/stop)
```

---

## Step 9: Overdue Tasks Phase (Optional)

After all suggested task groups, or if invoked with `overdue`/`active`:

```
---
You have N overdue active tasks. Review them now? (y/n)
---
```

If yes, present as a single group. Decision set tailored for active tasks:

- **k** (keep) — leave as-is, still active and overdue
- **d** (done) — mark complete in today's daily note
- **x** (cancel) — strikethrough in today's daily note
- **r [date]** (reschedule) — update due date
- **w [reason]** (on hold) — add ⏸️ marker with reason
- **h** (hold) — shorthand for on-hold with no reason

Write-back happens directly in today's daily note's Tasks section.

---

## Step 10: Final Receipt

```
> [!success] Task Triage Complete
> **Date:** [[YYYY-MM-DD]]
> **Suggested tasks reviewed:** N of N (N previously promoted, skipped)
>
> | Action      | Count |
> | ----------- | ----- |
> | Promoted    | N     |
> | Done        | N     |
> | Cancelled   | N     |
> | Rescheduled | N     |
> | Delegated   | N     |
> | Deferred    | N     |
>
> **By workstream:**
> - Compliance Review / Meridian Health: N promoted, N cancelled, N done, N deferred
> - Quality Tool: N promoted, N done, N cancelled
> - [...]
>
> **Overdue active tasks:** N reviewed — N rescheduled, N cancelled, N kept
>
> **Tasks added:** N new items in today's daily note
> **Source notes modified:** N daily notes updated (done/cancel markups)
> **Still deferred:** N tasks remain as suggestions for next review
```

If everything was cleared:

```
> Suggested task backlog: clear. ✅ Next accumulation starts with tomorrow's meetings.
```

---

## Rules

1. **Read before writing.** Always read a daily note before modifying it. Never overwrite existing content.
2. **Block IDs are sacred.** Every operation preserves the original block ID. No duplication, no regeneration (except for legacy tasks missing IDs).
3. **One group at a time.** Don't dump 90 tasks. Present a group, get decisions, write, move on.
4. **Suggested Tasks stay in source notes.** Done/cancel markups happen in the original daily note where the task was extracted. Promoted tasks are *copied* to today (not moved) — the source retains the record.
5. **Dedup against Tasks first.** Any task already promoted should never appear in the triage queue.
6. **Never auto-promote.** Every task requires an explicit decision. The default for unaddressed tasks is defer, not promote.
7. **Follow "carried from" chains.** Resolve all references to find the actual task lists, even if they're nested 3-4 daily notes back.
8. **Wikilinks everywhere.** All entity names in receipts and written tasks use `[[wikilinks]]`.


ARGUMENTS: $ARGUMENTS
