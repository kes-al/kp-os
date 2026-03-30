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

## Step 1: Find the Day to Close

Scan recent daily notes for any with an empty or missing `## End of Day` section:

```bash
obsidian search query="## End of Day" limit=10
```

Read each matching daily note and check whether the End of Day section has content below it or is empty/blank.

**Rules:**
- Exclude today's note if it was just created by `/startday` and has no Work Log entries yet
- If multiple unclosed days are found, list them and ask the user which to close. Default to the most recent unclosed day.
- If only one unclosed day is found, confirm it and proceed.

**Fallback (no CLI):** Read the last 7 daily notes via file I/O. Check each for empty End of Day sections.

---

## Step 2: Read the Target Day

```bash
obsidian read file="YYYY-MM-DD"
```

Parse the full daily note to understand:
- What was planned (## Plan)
- What tasks were active (## Tasks) — which are checked, which aren't
- What meetings happened (> [!info] Meetings callout)
- What was logged (## Work Log)
- What ideas were captured (## Ideas)
- What's in Suggested Tasks (## Suggested Tasks)

**Fallback (no CLI):** Direct file read of `/daily-notes/YYYY-MM-DD.md`.

---

## Step 3: Scan Modified Notes

Find all notes that were modified on the target date:

```bash
obsidian search query="modified:YYYY-MM-DD" limit=50
```

If the CLI doesn't support date-range search natively, fall back to:

```bash
# Check git for files modified that day
git log --name-only --after="YYYY-MM-DD 00:00" --before="YYYY-MM-DD 23:59" --pretty=format:""
```

Or use file modification timestamps via direct file system scan.

This gives us the full picture of what was touched that day — not just what was in the daily note.

---

## Step 4: Suggested Tasks Review

Before writing the End of Day, check `## Suggested Tasks` in the target daily note.

If there are unpromoted items (tasks still sitting in Suggested Tasks):

Present them to the user:

```
📋 You have N unpromoted suggested tasks from today's meetings:

1. - [ ] 2026-02-28 Follow up with [[Pat Sullivan]] on commerce pricing — from [[Platform RFP]] meeting
2. - [ ] 2026-03-03 Schedule DataTonic eval call — from [[Compliance Review]] meeting

Promote any to Tasks? (list numbers, "all", or "none")
```

**If "none" or skipped:** Leave them in Suggested Tasks. They're part of the daily note's historical record.

**If some promoted:** Move those items to `## Tasks` > `### Work` in the NEXT day's daily note (or today's if it's still the working day). Remove from Suggested Tasks. Note the promotion in the End of Day summary.

```bash
# Append promoted tasks to tomorrow's daily note
obsidian append file="YYYY-MM-DD" content="- [ ] promoted task..."
```

**If no suggested tasks:** Skip this step silently.

---

## Step 5: Generate End of Day Summary

Write the End of Day section:

### What Got Done

Summarize accomplishments based on:
- Checked tasks (`- [x]`) in Tasks
- Work Log entries
- Modified notes from Step 3

Group by workstream/client when multiple items relate to the same project. Use [[wikilinks]] for all entities.

### Carry-Over Tasks

List all unchecked tasks from Tasks that need to carry forward. **Preserve block IDs** — the same task keeps its ID across days:

```markdown
- [ ] ❗ Task that didn't get done — [[Client/Project]] ^t-0224-001
- [ ] Another carry-over ^t-0227-003
```

Tasks without block IDs (legacy): assign a new ID when carrying forward so they're trackable from this point on.

### Personal

Summarize personal task status from the `### Personal` section in Tasks:

```markdown
### Personal
- Completed: [list any checked personal tasks]
- Carry-over: [list unchecked personal tasks carrying forward, preserving block IDs]
```

If there were no personal tasks, omit this subsection.

### Connections Noticed

Use backlinks to surface unexpected connections:

```bash
obsidian backlinks file="YYYY-MM-DD"
```

This shows all notes that link to today's daily note. Combined with the modified notes from Step 3, look for:
- Notes modified today that relate to each other but aren't in the same project
- Patterns across meetings (same theme coming up in different client contexts)
- Ideas that connect to active project work

Write 1-3 sentences about any connections worth noting. If nothing stands out, write "None today."

### Write It

```bash
obsidian daily:append content="## End of Day\n\n### What Got Done\n..."
```

**Note:** If End of Day section already exists (empty), you may need to use `obsidian write` or direct file edit to fill it in-place rather than appending to the end.

**Fallback (no CLI):** Direct file write, inserting content under the `## End of Day` heading.

---

## Step 5b: Hub Note Staleness Check

After writing the End of Day, scan today's Work Log and completed tasks for project activity. For each project that had activity today:

1. Find the project's hub note (resolve from entity registry)
2. Check the hub note's modification date
3. If the hub note hasn't been updated in 7+ days AND today had decisions, status changes, or significant progress on that project:

```
> [!info] Stale hub notes detected
> These projects had activity today but their hub notes haven't been updated recently:
> - [[Project Name]] — last updated N days ago. Today: [brief description of activity]
>
> Want me to update any of these? (list numbers or "skip")
> I'll also re-sync project-instructions.md for any updated hub notes.
```

If the user says yes:
1. Read the hub note
2. Update relevant sections (Current State, Decision Log, Team, etc.) based on today's activity
3. Run `/sync-instructions [project]` to regenerate project-instructions.md
4. Include in the receipt: "📋 Copy updated project-instructions.md to Claude.ai"

If no projects are stale or had no significant activity, skip silently.

---

## Step 6: Career Evidence Capture

After writing the End of Day, do one more pass. Look for items that would matter in a performance review, promotion case, or manager update.

**Categories to scan for:**
- **Leadership:** Decisions made, people coached, conflicts resolved, strategy set
- **Client Impact:** Revenue influenced, problems solved, relationships strengthened
- **Technical:** Architecture decisions, technology evaluations, builds shipped
- **Team Development:** Mentoring, hiring, onboarding, unblocking direct reports
- **Innovation:** New ideas implemented, process improvements, experiments run
- **Cross-functional:** Work connecting teams, breaking silos, influence beyond immediate scope

**If evidence is found**, append to `/domains/career/evidence-log.md`:

```bash
obsidian append path="domains/career/evidence-log.md" content="## YYYY-MM-DD\n\n- **Category:** Description with [[wikilinks]]."
```

If the file doesn't exist, create it first:

```bash
obsidian create path="domains/career/evidence-log.md" content="---\ntitle: Career Evidence Log\ntype: note\ndomain: career\nstatus: active\ndate: YYYY-MM-DD\ntags: [career, evidence, review]\n---\n\n# Career Evidence Log\n\nRunning log of career-relevant work captured automatically by /closeday. Use this for annual reviews, promotion cases, and weekly manager updates.\n\n---\n" silent
```

**Rules for evidence capture:**
- Personal tasks are NOT included in career evidence capture. Only scan work-related accomplishments.
- Only log genuinely noteworthy things. Not every completed task qualifies.
- The bar: "Would I mention this in a review conversation with [[Jordan Park]]?"
- Keep descriptions tight — one sentence, maybe two. Daily note has full context.
- If nothing noteworthy happened, skip silently. Most days won't have entries.
- Never fabricate or inflate.

---

## Output

After everything is done, output a receipt using callout syntax:

```markdown
> [!success] Day Closed
> **Note closed:** [[YYYY-MM-DD]]
> **Completed:** N tasks
> **Carry-over:** N tasks
> **Suggested tasks reviewed:** N promoted, N left as suggestions
> **Ideas captured:** N (tagged #idea)
> **Career evidence:** [description or "Nothing stood out today"]
> **Connections noticed:** [brief description or "None"]
> **Intake:** [N items still waiting, or "✅ Clear"]
```
