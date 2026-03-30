## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scan the past 7 daily notes and all notes modified this week.

Generate a weekly review directly in the conversation:

1. **Accomplishments:** what got done (completed tasks, decisions made, notes created)
2. **Patterns:** what themes dominated the week?
3. **Drift check:** am I spending time on what I said matters? Compare actual activity against active project priorities. Flag misalignment: "You spent significant time on X but it's not in your active projects" or "[[Project Y]] got zero attention this week."
4. **Next week:** what should carry forward? What needs attention?
5. **Graduate candidates:** any ideas from this week worth promoting? (List them — don't auto-graduate)

## Carry-Forward Tasks

After the review, generate carry-forward tasks for next week:
- Unfinished high-priority tasks from this week
- Anything flagged in the drift check that needs deliberate attention
- Follow-ups from decisions made this week

Format as proper inline tasks and offer to add them to the next Monday's daily note (or today's if run on Monday):
- "Want me to add these N carry-forward tasks to Monday's daily note?"

If Monday's daily note doesn't exist yet, create it from the template.

## Output

```
## Weekly Review — [date range]

**Completed:** N tasks across N projects
**Top areas:** [[Entity 1]] (N tasks), [[Entity 2]] (N tasks)
**Drift:** [aligned / X got no attention / Y wasn't planned but took time]
**Career evidence this week:** N items logged
**Graduate candidates:** N ideas worth promoting
**Carry-forward:** N tasks for next week
```

## Hub Note Health Check

After the review, scan all projects and initiatives that had activity this week (meetings, tasks completed, Work Log mentions). For each:

1. Check the hub note's modification date
2. Flag any hub note not updated in 14+ days that had activity this week:

```
> [!warning] Stale Hub Notes
> These projects had activity this week but their hub notes are outdated:
> - [[Project Name]] — hub note last updated N days ago. This week: N meetings, N tasks completed.
> - [[Project Name]] — hub note last updated N days ago. This week: N meetings.
>
> Want me to update any? (list numbers or "skip")
```

If updated, auto-run `/sync-instructions` for each and remind to copy to Claude.ai.

Also check for projects with `project-instructions.md` that are older than their hub note — these are out of sync even if the hub note is recent.

## Backlog Check

After the review, read `/_meta/vault-backlog.md`. Check if any backlog items are now relevant based on how the week went:
- A friction point that matches a backlog item → flag it: "You hit [friction] this week — the backlog has [item] which could help. Worth prioritizing?"
- A capability you wished you had → check if it's already on the backlog. If not, suggest adding it.

Don't force it. Only mention backlog items that genuinely connect to the week's experience.

## Archival

Also save the full review to `/agent-output/reviews/weekly-[date].md`.
