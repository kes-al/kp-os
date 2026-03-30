---
title: 
type: rfp
client: 
project: 
status: [active|submitted|won|lost]
date: {{date:YYYY-MM-DD}}
value: 
duration: 
tags: [rfp]
---

# {{title}}

## Overview

<!-- What is this RFP for? Client, scope, value. -->


## Key Requirements

<!-- What does the client need? Summarize the critical asks. -->


## Our Approach

<!-- How are we positioning? What's the solution architecture? -->


## Technology Stack

<!-- What are we proposing? Link to [[domain]] and [[technology]] notes. -->


## Differentiators

<!-- What makes our response stand out? -->


## Team Proposed

<!-- Who are we putting forward? Use [[wikilinks]] for people. -->


## Timeline

<!-- Submission deadline, presentation dates, decision timeline. -->


## Recent Meetings

```dataview
TABLE date AS "Date"
FROM "work"
WHERE type = "meeting" AND contains(file.outlinks, this.file.link)
SORT date DESC
LIMIT 10
```

## Response Documents

<!-- Links to the actual response docs, or notes about each section. -->


## Lessons Learned

<!-- Post-submission: what worked, what didn't, client feedback. -->
