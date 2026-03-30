---
title: 
type: client
client: 
status: active
date: {{date:YYYY-MM-DD}}
---

# {{title}}

## Overview

<!-- Who is this client? What's the relationship? -->


## Active Projects

```dataview
TABLE status AS "Status", date AS "Last Updated"
FROM "work/clients/{{client}}/projects"
WHERE type = "project" OR type = "rfp"
SORT status ASC
```

## Key Contacts

<!-- Client-side and TAG-side stakeholders. Use [[wikilinks]] for people. -->


## Technology Landscape

<!-- What's their tech stack? What are we managing/building? -->


## Recent Meetings

```dataview
TABLE date AS "Date", project AS "Project"
FROM "work/clients/{{client}}"
WHERE type = "meeting"
SORT date DESC
LIMIT 15
```

## History

<!-- Key events, wins, challenges. Reverse chronological. -->


## Resources

<!-- Links to external resources — SharePoint, Notion, client portals -->
<!-- The `/files` subfolder holds client-level binary reference materials -->
