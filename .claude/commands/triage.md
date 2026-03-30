## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Sweep the entire `/intake` folder and process everything in it. This is the "clear my inbox" command.

If `$ARGUMENTS` is provided, use it as a filter:
- A date ("today", "yesterday", "2026-02-26", "this week") → only items from that timeframe
- A type ("meetings", "notes", "clips") → only that subfolder
- Both ("meetings today", "notes this week") → combined filter

If no argument, show everything unprocessed.

## Step 1: Scan Intake

Scan all subfolders of `/intake`:

- **`/intake/meetings/granola/`** — Granola-synced meeting notes. Check for processed counterparts by `granola_id`.
- **`/intake/meetings/manual/`** — Manually captured meeting notes/transcripts. Check if already processed by matching filename or title against notes in `/work` and `/agent-output`.
- **`/intake/notes/`** — Raw notes. Unprocessed = missing proper frontmatter, or `status: draft`, or has no wikilinks.
- **`/intake/clipper/`** — Web clips. Unprocessed = not yet tagged with a domain or routed to a permanent location.

## Step 2: Present the Queue

Group by type, show detected context:

```
## Intake Triage

Found N unprocessed items:

MEETINGS (N):
  1. 09:30 — Team Standup (granola, detected: internal)
  2. 10:00 — Acme RFP Review (granola, detected: [[Acme Corp]], [[Acme RFP]])
  3. Client call rough notes (manual, detected: [[Meridian Health]])

NOTES (N):
  4. "DAM integration thoughts" (detected: [[DAM]], [[Acme Corp]])
  5. "Untitled" (no entities detected)

CLIPS (N):
  6. "Article: The Future of DAM" (from damweek.com)
  7. "GitHub: awesome-rag-patterns" (from github.com)

Process all? (y/pick numbers/skip [type]/stop)
```

**Controls:**
- **y** — process all in order
- **pick 1 3 5** — process only selected items
- **skip meetings** — skip a whole type
- **stop** — exit

## Step 3: Process Each Item

Use the appropriate pipeline for each type:

### Meetings (granola + manual)
Full `/ingest-meeting` pipeline with three-tier routing:
1. Parse and structure (detect client, project, attendees, decisions, action items)
2. Route using three-tier logic:
   - **Tier 1:** Entity match + folder exists → route normally
   - **Tier 2:** Entity match + no folder → auto-scaffold client folder, then route
   - **Tier 3:** No entity match → save to `/agent-output/meetings/`, ask about context
3. Extract tasks to today's daily note
4. Suggest secondary updates
5. Output per-meeting receipt

### Notes
Full `/process` pipeline:
1. Wikilink all entities
2. Add/fix frontmatter
3. Format tasks
4. Tag ideas
5. Suggest permanent location
6. Show preview, apply on approval
7. **Move to permanent location** if approved (note leaves `/intake/notes/`)

### Clips
Lighter processing:
1. Add frontmatter if missing (type: resource, date, source URL)
2. Wikilink any recognized entities in the content
3. Detect relevant domain(s) from content
4. Suggest permanent location: `/domains/[domain]/` or a project's reference section
5. Show preview, move on approval

**Pause between items:**

```
## Item 3/7 Processed

[receipt for this item]

Next: "DAM integration thoughts" (note) → Continue? (y/skip/stop)
```

## Step 4: Batch Summary

```
## Triage Complete

**Processed:** N of N items
**Skipped:** N

**Meetings:** N processed → routed to work folders
**Notes:** N processed → N moved to permanent homes, N still in intake (no clear home)
**Clips:** N processed → N filed to domains, N still in intake

**Tasks extracted:** N total added to daily note
**Items remaining in intake:** N

**Pending suggestions:**
- Update [[Acme RFP]] hub note? (y/n)
- Add Morgan Liu to entity registry? (y/n)
```

## Rules

- Each item gets its full type-appropriate processing. No shortcuts.
- Show receipts per item so the user can gut-check in context.
- Items that get processed AND routed to a permanent home are moved out of `/intake`. The intake folder should trend toward empty.
- Items that get processed but have no clear home stay in `/intake` with improved frontmatter and wikilinks. They'll be easier to route next time.
- If `/intake` is completely empty, celebrate: "Intake clear. 🧹"
