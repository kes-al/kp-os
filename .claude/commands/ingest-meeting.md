## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Process a meeting transcript or synced Granola note into a structured note, route it to the right location, and suggest tasks for the daily note.

$ARGUMENTS

## Input Detection

- If `$ARGUMENTS` is a file path (e.g., `/intake/meetings/granola/2026-02-26-team-standup.md`) → read that file
- If `$ARGUMENTS` is raw text → process as a pasted transcript
- If `$ARGUMENTS` is just a meeting name or partial match → search `/intake/meetings/` (both `/granola` and `/manual`) for matching files and confirm

When reading a Granola-synced file, carry the Granola identifiers into the processed note but **rename the fields** to `source_id` and `source_url` to prevent the Granola Sync Plus plugin from detecting and overwriting the processed note. The plugin matches on `granola_id` in frontmatter — using `source_id` avoids this.

## Step 1: Parse and Structure

1. Read the transcript/note and detect:
   - **Client** — match against `/_meta/entities.md` clients table (including aliases)
   - **Project** — match against entities projects tables
   - **Attendees** — match names against entities people table, note any unrecognized names. If the source is a Granola sync with attendee tags, use those.
   - **Date** — from transcript metadata, Granola frontmatter, or today's date
   - **Topic** — generate a concise meeting topic from the content

2. Restructure into the meeting note template format with proper frontmatter:

```yaml
---
title: [date] [Topic]
type: meeting
client: [detected-client]
project: [detected-project]
date: YYYY-MM-DD
status: complete
tags: []
source: granola
source_id: [from granola_id — renamed to avoid plugin overwrite]
source_url: [from granola_url — renamed to avoid plugin overwrite]
---
```

3. Add an **Attendees** section immediately after the title heading:
   - List each attendee with `[[wikilinks]]` for anyone in the entity registry
   - For unrecognized names, list with role/company context (e.g., `Sebastian — ops/technology, [[Greenfield]]`)
   - Always end with: `- [ ] Confirm/add attendees` as a placeholder for the user to verify

4. Fill in sections:
   - **Context** — what was the meeting about, what was the goal
   - **Key Discussion Points** — main topics, with [[wikilinks]] for all recognized entities
   - **Decisions Made** — what was decided, include the reasoning (the WHY)
   - **Action Items** — all action items from the meeting, with owners noted. This is the historical record — ALL items go here regardless of who owns them.
   - **Open Questions** — what's unresolved
   - **Connections** — what other vault notes/projects/clients this relates to

## Step 2: Route the Meeting Note

**Work meetings — high confidence routing** (entity match, not a guess):

If both client and project are detected, save to:
`/work/clients/[client]/projects/[project]/meetings/[date]-[topic].md`

If only the client is detected (no specific project), save to:
`/work/clients/[client]/meetings/[date]-[topic].md`

For internal meetings, save to:
`/work/[company]/projects/[project]/meetings/[date]-[topic].md`

For internal initiative meetings or projects under initiatives, save to:
`/work/[company]/initiatives/[initiative]/meetings/[date]-[topic].md`
`/work/[company]/initiatives/[initiative]/projects/[project]/meetings/[date]-[topic].md`

**Tier 1: Entity match + folder exists** → route normally to client/project/meetings path.

**Tier 2: Entity match + no folder** → auto-scaffold the client folder structure using the same pattern as `/new-client` (hub note, /files, /meetings, /projects), then route normally. Note in the receipt: "Auto-created [[Client]] folder structure." This covers clients that are in the entity registry but haven't had folders created yet (e.g., Meridian Health/Meridian).

**Tier 3: No entity match** → save to `/agent-output/meetings/` and ask:
- If it looks like a work meeting with an unrecognized company: "I detected 'Globex' but it's not in the entity registry. Is this a new client? Want me to run `/new-client Globex`?"
- If it looks personal: "This looks like a personal meeting. Once you have a home for it (e.g., `/domains/health/`, `/domains/finance/`), I can move it there."
- If you genuinely can't tell: "Couldn't confidently detect the context. Where should this live?"

Always tell the user where the note was saved.

## Step 3: Update Daily Note

### Meetings Callout
Add a line to the current working day's `> [!info] Meetings` callout with the meeting time (if known) and a wikilink to the **processed** note in its final location:
- `> - HH:MM [[path/to/processed/note|Meeting Title]]`
- If time isn't available, just use the link without a time prefix.
- If the callout doesn't exist yet, create it in the correct position (after status bar, before Plan callout).

### Inline Task Triage
Extract action items from the meeting that are **the user's responsibility** — things he personally needs to do, follow up on, or is the accountable bottleneck for. Skip tasks owned by other people (those stay in the meeting note's Action Items section as the historical record).

**Ownership filter:** Only extract tasks where the user is clearly the owner:
- He was directly asked to do something
- He volunteered or committed to a follow-up
- He's the only person who can unblock something
- It's a decision only he can make

Do NOT extract tasks where:
- Someone else was assigned the action ("Beth to complete slides" → stays in meeting note only)
- It's a team-wide action with no specific owner
- It's aspirational/vague with no clear next step

**Present for immediate triage** — don't silently dump into Suggested Tasks. Show them right after processing:

```
📋 N action items from this meeting:

1. [ ] 2026-03-31 Set up weekly recurring meeting with [[Morgan Liu]] ^t-0330-060
2. [ ] 2026-04-04 Scope Bureau Works pipeline as single connector ^t-0330-064
3. [ ] 2026-04-04 Get added to Valmont/Merkle Salesforce conversation ^t-0330-062

Decide now: p (promote to Tasks) | x (cancel) | - (defer to Suggested Tasks)
Bulk: "p 1-2 x 3" or "p all"
```

- Always assign block IDs (`^t-MMDD-NNN`). Scan the daily note for existing IDs and increment.
- Default to regular priority unless context makes it clearly urgent
- If no due date is mentioned, set it to 3 business days from today
- Include meeting context so the task makes sense standalone

**Apply decisions immediately:**
- **p (promote)** → write to `## Tasks` > `### Work` in today's daily note
- **x (cancel)** → don't write anywhere. Task stays only in the meeting note's Action Items as historical record.
- **- (defer)** → write to `## Suggested Tasks` in today's daily note (old behavior, for items the user isn't sure about yet)

**Why inline triage:** Context is freshest right after the meeting. Triaging 3-5 tasks per meeting takes 10 seconds. Letting them accumulate for weeks creates a 108-item backlog that takes an hour to clear.

If today's daily note doesn't exist, create it from the template at `/templates/daily-note.md`.

## Step 4: Suggest Secondary Updates

After saving the meeting note, check if the meeting surfaced anything that should update other notes:

- **Decisions** that affect a project's direction → suggest updating the project hub note's Decision Log or Current State section
- **New contacts** mentioned → suggest adding to the client hub note's Key Contacts
- **Status changes** on a project → suggest updating the project hub note's Current State
- **Commitments made to/by specific people** → suggest noting on relevant person pages under `/work/[company]/admin/team/`

List each suggestion with what you'd write. Don't auto-write — ask: "Want me to update any of these?"

### Hub Note Staleness Check

After listing suggestions, check the project's hub note modification date. If the hub note hasn't been updated in 7+ days AND this meeting had decisions or status changes:

```
> [!info] Hub note may be stale
> [[Project Name]] hub note was last updated N days ago. This meeting had [N decisions / status changes].
> Want me to update the hub note? (y/n)
> If yes, I'll also run `/sync-instructions` to keep the Claude.ai briefing current.
```

If the user says yes:
1. Update the hub note's relevant sections (Decision Log, Current State, Team, etc.)
2. Automatically run `/sync-instructions [project]` to regenerate `project-instructions.md`
3. Remind in the receipt: "📋 Copy updated project-instructions.md to Claude.ai"

## Step 5: Output Summary

After everything is done, output a structured summary so the user can gut-check what happened:

```
## Meeting Processed

**Source:** /meetings/granola/2026-02-25-rfp-kickoff.md (Granola sync)
**Note saved to:** /work/clients/acme-corp/projects/rfp/meetings/2026-02-25-rfp-kickoff.md
**Client:** [[Acme Corp]]  |  **Project:** [[Acme RFP]]
**Attendees:** [[Dana Chen]], [[Alex Rivera]], Morgan Liu — vendor contact (not in registry)

**Suggested tasks for daily note (2):**
- [ ] ❗ 2026-02-28 Send revised timeline to [[Dana Chen]] ^t-0225-001
- [ ] 2026-02-28 Review DAM integration spec with [[Alex Rivera]] ^t-0225-002

**Other action items (in meeting note only):**
- Morgan Liu: Send vendor pricing breakdown by Friday
- [[Alex Rivera]]: Update technical architecture diagram

**Decisions captured (1):**
- Lead with DAM integration narrative over commerce platform

**Suggested updates:**
- Update [[Acme RFP]] hub note with DAM-first narrative shift? (y/n)
- Add Morgan Liu to entity registry? (y/n)
```

Keep this tight — it's a receipt, not a report. One glance should confirm everything landed in the right place.

## Rules

- Preserve the substance of what was said. Don't over-summarize — if someone made a specific point, capture it.
- Every entity that exists in the registry gets wikilinked. Every single one.
- For unrecognized attendee names, note them in the attendees list as-is and flag in the summary.
- Decisions MUST include reasoning. "We decided X" is useless. "We decided X because Y, and this means Z" is useful.
- Meeting note filenames: `YYYY-MM-DD-[topic-hyphenated].md` (e.g., `2026-02-25-acme-corp-rfp-kickoff.md`)
- After processing a Granola-synced file, **move** (use `mv`, not `cp`) the raw source file to `/intake/meetings/granola/processed/`. This removes it from the intake folder. The Granola plugin continues syncing new meetings to `/intake/meetings/granola/` — the processed subfolder won't interfere.
- **Meeting notes are the historical record.** All action items (everyone's) stay in the meeting note. Only the user's items get suggested to the daily note, and only as suggestions — never directly to Tasks.
