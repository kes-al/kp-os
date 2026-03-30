## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Process multiple Granola-synced meeting notes in sequence. Finds unprocessed meetings and steps through them one at a time.

## Step 1: Find Unprocessed Meetings

Scan `/intake/meetings/` (both `/granola` and `/manual` subfolders) for all `.md` files. For Granola files, check if a processed version exists by matching `granola_id` against notes in `/work/` and `/agent-output/meetings/`. For manual files, check by matching filename or title.

**Unprocessed** = exists in `/intake/meetings/` but no processed note found elsewhere.

If a date filter is provided in `$ARGUMENTS` (e.g., "today", "yesterday", "2026-02-26", "this week"), only include meetings from that date range. If no argument, default to today.

## Step 2: Present the Queue

Show the list of unprocessed meetings:

```
## Meeting Queue

Found N unprocessed meetings:

1. 09:30 — Team Standup (detected: internal)
2. 10:00 — Acme RFP Review (detected: [[Acme Corp]], [[Acme RFP]])
3. 11:30 — Northstar Commerce Check-in (detected: [[Northstar]], [[Northstar Commerce]])
4. 14:00 — Doctor appointment (detected: personal)
5. 15:00 — Unknown meeting title (detected: unclear)

Process all? Or pick by number to skip/reorder.
```

Wait for confirmation before proceeding. the user may want to skip some (e.g., skip a quick 1:1 that doesn't need processing) or reorder.

## Step 3: Process Each Meeting

For each meeting in the confirmed queue, run the full `/ingest-meeting` pipeline:

1. Parse and structure (detect client, project, attendees, decisions, action items)
2. Route the meeting note to the correct location
3. **Inline task triage** — present extracted tasks immediately for p/x/- decisions (promote, cancel, defer). Don't silently dump into Suggested Tasks.
4. Suggest secondary updates + hub note staleness check

**After each meeting**, output the receipt and pause:

```
## Meeting 1/5 Processed

**Source:** /meetings/granola/2026-02-26-team-standup.md
**Note saved to:** /work/[company]/projects/content-engine/meetings/2026-02-26-team-standup.md (or /work/[company]/initiatives/[initiative]/meetings/ for initiative meetings)
**Tasks:** 2 promoted, 1 cancelled, 0 deferred
**Decisions captured:** 1

**Suggested updates:**
- Update [[Content Engine]] hub note with timeline change? (y/n)

Ready for next meeting? (y/continue/skip next/stop)
```

**Controls between meetings:**
- **y** or **enter** — process next meeting
- **skip** — skip the next meeting in queue
- **stop** — end the batch, show summary of what was processed so far

## Step 4: Batch Summary

After all meetings are processed (or the batch is stopped), output a full summary:

```
## Batch Complete

**Processed:** 4 of 5 meetings (1 skipped)
**Total tasks added:** 8
**Total decisions captured:** 3

**Notes saved:**
1. /work/[company]/projects/content-engine/meetings/2026-02-26-team-standup.md (or /work/[company]/initiatives/[initiative]/meetings/ for initiative meetings)
2. /work/clients/acme-corp/projects/rfp/meetings/2026-02-26-rfp-review.md
3. /work/clients/northstar/projects/commerce/meetings/2026-02-26-commerce-checkin.md
4. /agent-output/meetings/2026-02-26-doctor-appointment.md (personal — no routing yet)

**Skipped:** 1 (15:00 Unknown meeting)

**Suggested updates still pending:**
- Update [[Content Engine]] hub note with timeline change? (y/n)
- Update [[Acme RFP]] hub note with DAM-first narrative shift? (y/n)
- Add Morgan Liu to entity registry? (y/n)
```

## Rules

- Each meeting gets the full `/ingest-meeting` treatment — no shortcuts on quality.
- Don't batch the secondary update suggestions silently. Show them per-meeting so the user can approve in context, then collect any unanswered ones in the final summary.
- If a meeting has no meaningful content (e.g., a 2-minute "we'll reschedule" call), say so and suggest skipping rather than generating an empty structured note.
- Respect the same three-tier routing logic as `/ingest-meeting`:
  - **Tier 1:** Entity match + folder exists → route normally
  - **Tier 2:** Entity match + no folder → auto-scaffold client folder, then route normally
  - **Tier 3:** No entity match → save to `/agent-output/meetings/`, ask about context
