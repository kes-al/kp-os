---
title:
type: initiative
status: active
owner: ""
stakeholders: []
date: {{date:YYYY-MM-DD}}
tags: [initiative]
---

# {{title}}

## Vision

<!-- What is this initiative about? What's the strategic narrative? One paragraph. -->

## Strategy

<!-- Current strategic approach. Updated as the initiative evolves. -->

## Projects

```dataview
TABLE status AS "Status", date AS "Date"
FROM ""
WHERE type = "project" AND contains(file.outlinks, this.file.link)
SORT date DESC
```

### Confirmed

<!-- - [[Project Name]] — One-line description. -->

### Candidates

<!-- - [[Project Name]] — Why it might fit under this initiative. -->

## Team

<!-- Key people involved. Use wikilinks: [[Person Name]] — Role/context -->

## Artifacts

%% Link strategy decks, proposals, executive presentations here as they're created. %%

## Key Decisions

%% Running log — format: **Decision** (YYYY-MM-DD) — Context and rationale. WHY: reason. %%

## Status & Timeline

- **Current phase:**
- **Next milestone:**
- **Target:**
