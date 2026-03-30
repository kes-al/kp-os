---
title: Daily Workflow
type: resource
date: 2026-03-30
tags: [guide, reference]
---

# Daily Workflow

Step-by-step reference for the vault routine, morning to night.

## Morning (5 min)

1. **Open Claude Code in the vault directory.** The SessionStart hook fires automatically -- loads today's daily note content and open task summary. You have context before typing anything.
2. **Run `/startday`.** Creates today's daily note (`YYYY-MM-DD.md`), pulls open/overdue tasks (deduplicated by block ID), generates the prioritized plan, writes the status bar callout. If you're traveling, it populates the Travel section too.
3. **Scan the daily note dashboard.** Check three things fast:
   - `> [!abstract]` status bar -- task counts, meeting count, one-liner focus
   - `> [!warning]` blocked callout -- anything stuck? Handle or delegate first
   - `> [!note]- Plan` -- expand it, know your must-do items
4. **Load deeper context if needed.**
   - `/context` -- full vault briefing (active clients, projects, open tasks across everything)
   - `/context-load [project]` -- focused context for a specific project or client

> [!tip] If yesterday wasn't closed, `/startday` will prompt you to run `/closeday` first. The vault tracks the "open day" by whichever daily note has an empty End of Day section.

## During the Day

5. **Before a meeting:** `/context-load [client]` -- pulls client MOC, recent meetings, project status, code docs. Gets you prepped in 30 seconds.
6. **After a meeting:** `/ingest-meeting [transcript or path]` -- structures the raw transcript into a formatted meeting note, routes it to the correct client/project folder, extracts your action items into Suggested Tasks.
7. **Batch-process meetings:** `/ingest-batch [today]` -- finds all unprocessed Granola meetings for the date and ingests them in sequence. Use this if you had back-to-back meetings and didn't process between them.
8. **Quick capture:** `/capture [whatever]` -- natural language routing:
   - `/capture task Follow up with [[Jordan Park]] on FE staffing` -- goes to Tasks > Work
   - `/capture idea What if we used pgvector for the RFP engine` -- goes to Ideas
   - `/capture Wayne confirmed the Salsify timeline is Q3` -- goes to Work Log
9. **Mark tasks done:** Tell Claude Code what you finished ("I finished the Meridian RFP draft") and it checks off the task in the daily note.
10. **Add tasks directly:** `/capture task [description]` or just say "add a task: [description]". Both route to Tasks > Work with proper format, block ID, and wikilinks.

> [!tip] `/capture` writes to Tasks because you're deliberately committing. `/ingest-meeting` writes to Suggested Tasks as a holding pen -- those aren't active until you promote them.

## End of Day (5 min)

11. **Run `/closeday`.** Summarizes accomplishments, surfaces connections between the day's work, formats carry-over tasks (preserving block IDs), captures career evidence to `/domains/career/evidence-log.md`. Fills the `## End of Day` section.
12. **Review Suggested Tasks.** Anything in `## Suggested Tasks` from today's meeting ingests -- promote to Tasks (tell Claude), skip, or defer. Unprocessed items carry forward with `/startday` the next morning.
13. **Run `/commit`.** Saves everything to git. Clean snapshot of the day's vault state.

> [!tip] `/closeday` separates personal task summaries from work. Personal tasks never appear in career evidence capture.

## Weekly

14. **`/weekly-review`** -- Surfaces patterns across the week, checks for drift from priorities, generates next-week focus areas.
15. **`/triage-tasks`** -- Batch review of accumulated suggested tasks across multiple days. Promote, defer, or discard in bulk.
16. **`/graduate`** -- Scans Ideas sections and `#idea` tags across recent daily notes. Promotes worthy ones to standalone notes in the appropriate domain or project folder.

> [!tip] Other useful commands for weekly maintenance:
> - `/audit [path]` -- check a folder for missing frontmatter, broken links, orphaned notes
> - `/drift` -- discover unexpected connections in the vault graph
> - `/emerge` -- surface themes emerging across recent notes

## Quick Reference

| Time | Command | What it does |
|---|---|---|
| Morning | `/startday` | Create daily note, pull tasks, generate plan |
| Pre-meeting | `/context-load [client]` | Load client/project context |
| Post-meeting | `/ingest-meeting [path]` | Structure transcript, extract tasks |
| Anytime | `/capture [text]` | Route tasks, ideas, observations |
| Anytime | `/ingest-batch [date]` | Process all Granola meetings for a date |
| Evening | `/closeday` | Summarize, carry over, capture evidence |
| Evening | `/commit` | Git snapshot |
| Weekly | `/weekly-review` | Week patterns and next-week plan |
| Weekly | `/graduate` | Promote ideas to standalone notes |
