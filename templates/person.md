---
title: 
type: person
role: 
org: 
relationship: [boss|direct-report|peer|cross-team|leadership|client|vendor]
status: active
date: {{date:YYYY-MM-DD}}
aliases: []
tags:
  - person
---

# {{title}}

**Role:** 
**Org:** 
**Reports to:** 

## Working Context

<!-- Current collaborations, how you interact, what they care about -->


## Meetings

```dataview
TABLE date AS "Date", client AS "Client", project AS "Project"
FROM "work" OR "intake"
WHERE type = "meeting" AND contains(file.outlinks, this.file.link)
SORT date DESC
LIMIT 20
```

## Shared Projects

```dataview
TABLE client AS "Client", status AS "Status"
FROM "work"
WHERE (type = "project" OR type = "rfp") AND contains(file.outlinks, this.file.link)
SORT status ASC
```

## Recent Mentions

```dataview
TABLE date AS "Date"
FROM "daily-notes"
WHERE contains(file.outlinks, this.file.link)
SORT date DESC
LIMIT 10
```

## Notes

<!-- Rolling context from interactions. Add observations, preferences, communication style. -->
