Based on my current projects and priorities, suggest a schedule for this week.

1. Read this week's daily notes (what's already happened)
2. Read all active project hub notes for current status and priorities
3. Collect all tasks with due dates this week
4. Check for meetings noted in daily notes and Work Logs

Output a structured day-by-day breakdown directly in the conversation:

```
### Monday
- **Priority block (2-3 hrs):** [what needs deep focus] — context: [[Project]]
- **Meeting prep:** [what to prepare for, if anything noted]
- **Tasks due:** [list with priorities]

### Tuesday
...
```

For each day:
- **Priority blocks** — what needs the most focused time, based on due dates and project urgency
- **Meeting prep** — any upcoming meetings that need preparation (detected from daily notes or tasks)
- **Admin batching** — small tasks to batch together (emails, reviews, approvals)
- **Creative/thinking time** — protect at least one block per week for non-urgent exploration

## Conflict Detection

Flag problems:
- "⚠️ Wednesday has 4 due tasks plus 2 meetings — consider moving [[Task]] to Thursday"
- "⚠️ [[Project X]] has a Friday deadline but no time allocated before then"
- "⚠️ No thinking time protected this week — everything is reactive"

## Follow-up

After presenting the schedule, offer:
- "Want me to add time-block tasks to your daily notes? (e.g., `- [ ] Deep work: [[Acme RFP]] architecture review 📅 2026-02-26 ⏫`)"
- Only create tasks if approved. Show exactly what would be added to which daily notes.
