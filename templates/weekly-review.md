---
title: "Weekly Review — {{date:YYYY-MM-DD}}"
type: note
domain: pkm
date: {{date:YYYY-MM-DD}}
tags: [weekly-review]
---

# Weekly Review — {{date:dddd, MMMM D, YYYY}}

## This Week's Daily Notes

```dataview
TABLE date AS "Date"
FROM "daily-notes"
WHERE date >= date(today) - dur(7 days)
SORT date DESC
```

## Accomplishments

<!-- What got done this week? Big wins, decisions made, things shipped. -->


## Patterns

<!-- What themes or recurring threads showed up? -->


## Drift Check

<!-- Am I doing what I said matters? Compare this week's actual work against stated priorities. -->


## Next Week Priorities

<!-- What MUST happen next week? -->


## Graduation Candidates

<!-- Ideas, observations, or threads worth promoting to standalone notes. -->


## Career Evidence

<!-- Anything review-worthy from this week? -->
