## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

## CLI Check

Verify the Obsidian CLI is available:

```bash
obsidian version
```

If this fails (Obsidian not running), fall back to direct file I/O for the entire command. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 0: Check for Active Trip

Before building the daily note, check if today falls within an active trip.

### 0a. Scan trip notes

Read all files in `domains/travel/trips/` and check their frontmatter:
- `status: active`
- Parse the itinerary to determine trip date range

Alternatively, check the entity registry `/_meta/entities.md` under the Travel > Trips section for trip dates.

### 0b. Determine travel context for today

If today falls within a trip's date range, read the full trip note and extract:
- **Day label:** What day of the trip is this? (e.g., "Day 3: Madrid — Meridian pitch prep")
- **Today's flights:** Any flights departing or arriving today (times, terminals, airline, seat)
- **Current hotel:** Name, address, phone, confirmation number, check-out date
- **Timezone:** Local timezone and offset from home (your local timezone)
- **Key events today:** Meetings, pitch days, travel days from the trip schedule
- **Upcoming travel:** Next flight or city change within 2 days
- **Open trip tasks:** Any unchecked tasks from the trip note (e.g., "book London hotel")
- **Alerts:** Anything flagged with `==highlights==` in the trip note (e.g., unbooked hotels)

Store this as `travel_context` for use in Step 3 and Step 4.

### 0c. Also check previous daily note

If the previous daily note has a `## Travel` section, read it. This serves as a fallback if the trip note hasn't been fully populated yet — carry the travel callout forward. Prefer the trip note as source of truth, but if the trip note doesn't have today's details, reuse the previous day's Travel section and update the day label.

---

## Step 1: Create Today's Daily Note

```bash
obsidian daily:create silent
```

This creates today's daily note from the configured template if it doesn't already exist. The `silent` flag prevents it from stealing focus in Obsidian.

If the note already exists, the command is a no-op. Read it:

```bash
obsidian daily:read
```

Check if `## Tasks` already has content. If yes, this day was already started — confirm with the user before overwriting.

**Fallback (no CLI):** Check if `/daily-notes/YYYY-MM-DD.md` exists. If not, copy `/templates/daily-note.md` and replace template variables.

---

## Step 2: Scan for Open Tasks

### 2a. CLI task scan

```bash
obsidian tasks daily todo
```

This returns all unchecked tasks from daily notes. The CLI understands:
- Checkbox format (`- [ ]`)
- Priority markers (`❗`)
- Due dates (inline dates like `📅 YYYY-MM-DD`)
- Wikilinks (preserved in output)

### 2b. Vault-wide overdue scan

```bash
obsidian search query="- [ ]" limit=100
```

Filter results for tasks with dates before today. This catches tasks in non-daily-note locations (project notes, client notes, meeting notes) that have due dates.

### 2c. Filtering rules

**INCLUDE** tasks from:
- `## Tasks` > `### Work` sections in any daily note from the last 7 days
- Any note with a task dated today or overdue

**EXCLUDE:**
- `## Suggested Tasks` sections — these are unreviewed candidates. Never pull them forward.
- Tasks in `## End of Day` carry-over lists (these are formatted references, not active tasks)
- Checked tasks (`- [x]`)
- Tasks with strikethrough (`~~`)

Also scan `### Personal` sections (under `## Tasks`) in recent daily notes. Personal tasks carry forward just like work tasks — same block ID dedup, same filtering rules.

### 2d. Deduplicate by Block ID

Tasks carry block IDs in the format `^t-MMDD-NNN` (e.g., `^t-0227-003`). The same task carried across multiple daily notes will have the same block ID.

**Dedup rule:** Group tasks by block ID. For each ID, keep only the most recent instance (latest daily note). This collapses 5 copies of "Add tech slides to Acme RFP" into 1.

**Tasks without IDs:** Legacy tasks may lack block IDs. For these, fall back to text-based dedup (match on description, ignoring date differences). When writing them to today's Tasks section, **assign a new block ID** so they're trackable going forward.

**ID assignment:** Scan today's daily note for existing `^t-MMDD-NNN` IDs. Find the highest NNN. New IDs start from the next number. Format: `^t-MMDD-NNN` where MMDD is today's date and NNN is zero-padded (001, 002, 003).

**Fallback (no CLI):** Read the last 7 daily notes via file I/O. Grep for `- [ ]` lines. Apply the same filtering and dedup logic.

---

## Step 3: Write Travel Section

If `travel_context` was populated in Step 0, write a `## Travel` section at the top of the daily note (after the h1 title, before the status bar callout).

Format as an info callout:

```markdown
## Travel

> [!info] [[Trip Note Name]] — Day N: City — Brief context
>
> **Today:** Flight details if traveling, or "Full day in City" if not.
>
> **Hotel:** Name, Address. Confirmation NUMBER. Phone NUMBER. Check-out DATE.
>
> **Office:** Office address for current city (from trip note).
>
> **Timezone:** TZ (UTC±X) — N hours ahead/behind your city.
>
> **This week:** Brief summary of what's coming (pitch days, travel days, key meetings).
>
> Any alerts (e.g., ⚠️ ==London hotel still not booked==)
```

**Key rules:**
- Link to the trip note with `[[Trip Note Name]]`
- Only show today's relevant logistics — don't dump the entire itinerary
- Hotel info should always be present (you'll look at this on your phone)
- Flights only appear on days you're actually flying
- Use `==highlights==` for anything that needs attention
- If no active trip, leave the `## Travel` section empty or remove it entirely

Write using:

```bash
obsidian daily:append content="## Travel\n\n> [!info] ..."
```

**Fallback (no CLI):** Write directly to the daily note file after the h1 heading.

---

## Step 4: Write Tasks

Group all open tasks into today's `## Tasks` section:

```
### Work
- [ ] ❗ 2026-02-24 Task description with [[wikilinks]] ^t-0224-001
- [ ] ❗ 2026-02-27 Today's urgent task ^t-0227-001
- [ ] 2026-02-27 Today's regular task ^t-0227-002
- [ ] 2026-02-20 Another overdue task ^t-0220-003
- [ ] Undated task from previous days ^t-0225-005
- [ ] 2026-02-28 Tomorrow's task ^t-0227-003
- [ ] 2026-03-03 Next week's task ^t-0227-004

### Personal
- [ ] 2026-03-28 File FSA claim — [[Finance]] ^t-0327-010
```

Tasks in `### Work` are a flat list: `❗` tasks first, then sorted by date (oldest first). No sub-headers for overdue/due today/carry-over/upcoming — just one sorted list. Personal tasks sort by date only. Carry forward from previous day's `### Personal` section.

Write using:

```bash
obsidian daily:append content="### Work\n- [ ] ❗ ..."
```

**Fallback (no CLI):** Write directly to the daily note file, inserting after the `## Tasks` heading.

---

## Step 5: Generate Plan

Based on the Tasks, generate a prioritized plan as a **collapsed callout**:

```markdown
> [!note]- Plan (click to expand)
>
> ### 1. Must-Do
> - **Task summary** — brief context. [[Client/Project]]
>
> ### 2. Should-Do
> - **Task summary** — brief context. [[Client/Project]]
>
> ### 3. Could-Do
> - **Task summary** — brief context. [[Client/Project]]
```

**Must-Do:** All `❗` tasks + all tasks due today. These are non-negotiable.

**Should-Do:** Regular overdue tasks + carry-overs with active project context. These should get done if time allows.

**Could-Do:** Upcoming tasks that could be started early, ideas worth exploring, non-urgent maintenance.

For each item, write a human-readable summary (not just the raw task text) with relevant [[wikilinks]] and brief context on why it matters today.

**Personal tasks** are NOT included in the Must-Do/Should-Do/Could-Do plan. They appear in their own `### Personal` section under Tasks but the Plan focuses on work priorities. If a personal task is urgent (e.g., deadline today), mention it as a one-liner at the bottom of the Plan: "**Personal:** N personal tasks due today."

Write to the Plan section:

```bash
obsidian daily:append content="> [!note]- Plan (click to expand)\n>\n> ### 1. Must-Do\n> - **Finalize Meridian deck** ..."
```

**Travel-aware planning:** If `travel_context` exists, factor it into the Plan:
- Timezone differences affect meeting availability (e.g., 6 hours ahead means your city colleagues aren't online until your afternoon)
- Travel days have limited work capacity — deprioritize deep work
- Pitch/meeting days should have prep as Must-Do
- Flag any open trip tasks (like "book hotel") as Must-Do

**Note:** The Plan callout is placed after the status bar and meetings callouts, before `## Tasks`. If using `daily:append`, you may need to write the full note content in order (status bar → meetings → plan → Tasks → etc.) or use direct file writes for positional insertion.

**Fallback (no CLI):** Direct file write to position Plan content correctly.

---

## Step 5a: Write Status Bar and Meetings Callouts

Before the Plan callout, write the **status bar** and **meetings** callouts:

**Status bar** — a single-line callout showing the week number and key stats:

```markdown
> [!abstract] Week N | Day — N work tasks, N personal | N meetings today
```

This goes at the very top of the daily note body (after Travel if present, before everything else).

**Meetings callout** — lists the day's meetings. Populated with any already-known meetings (from calendar or previous processing):

```markdown
> [!info] Meetings
> - HH:MM [[path/to/meeting-note|Meeting Title]]
> - HH:MM [[path/to/meeting-note|Meeting Title]]
```

This goes after the status bar, before the Plan callout. If no meetings are known yet, write an empty callout:

```markdown
> [!info] Meetings
> *No meetings linked yet.*
```

**Note:** `/ingest-meeting` adds meeting links to this callout (not a `## Meetings` h2 section).

---

## Step 6: Suggested Tasks Reminder

Check the last 3 daily notes for items in `## Suggested Tasks` that were never promoted to Tasks:

```bash
obsidian search query="## Suggested Tasks" limit=5
```

Then read those notes and count unpromoted items.

If any exist, add a note at the bottom of the Plan:

> 💡 You have N unpromoted suggested tasks from recent meetings. Review them when you have a moment.

Don't list them individually — just the nudge. the user can check previous daily notes to review and promote.

---

## Step 7: Processed File Cleanup

Delete processed Granola files older than 7 days. These are raw transcripts that have already been structured into meeting notes — the originals live in Granola (the app) and the `source_url` in each processed note links back.

```bash
find intake/meetings/granola/processed -name "*.md" -mtime +7 -delete
```

Report how many were purged (if any) in the output receipt.

---

## Step 8: Intake Status

Check for unprocessed items in `/intake`:

```bash
obsidian search query="path:intake" limit=50
```

Or list files:

```bash
obsidian files path="intake/meetings" total
obsidian files path="intake/notes" total
obsidian files path="intake/clipper" total
```

Exclude `/intake/meetings/granola/processed/` from the count.

---

## Output

After building the daily note, output a receipt using callout syntax:

```markdown
> [!success] Day Started
> **Daily note:** [[YYYY-MM-DD]]
> **Travel:** [[Trip Note Name]] — Day N in City (or "✅ Home" if no active trip)
> **Tasks pulled:** X work tasks (N high-priority), Y personal tasks
> **Plan generated:** X must-do, Y should-do, Z could-do
> **Heaviest area:** [[Entity]] (N tasks)
> **Unpromoted suggestions:** N from recent meetings
> **Processed cleanup:** Purged N files older than 7 days (or "None to purge")
> **Intake:** N meetings, N notes, N clips waiting (or "✅ Clear")
```

If there are more than 5 overdue tasks, add:

```markdown
> [!warning] Task overload
> You have X overdue tasks. Consider triaging — some may need to be dropped or rescheduled.
```
