---
title: New Client Onboarding
type: resource
date: 2026-03-30
tags: [guide, reference]
---

# New Client Onboarding

Step-by-step reference for onboarding a new client in the vault.

## 1. Scaffold the Client

```
/new-client "Client Name"
```

This creates the full folder structure under `work/clients/[client-name]/`:

- `[Client Name].md` -- Hub note with frontmatter
- `/files` -- Binary reference materials (not in git)
- `/meetings` -- Client-level meeting notes
- `/projects` -- Empty, ready for first project

The command also adds the client to `_meta/entities.md` and `work/clients/Clients.md`.

## 2. Fill in the Hub Note

Open the generated hub note and populate these sections:

- **Overview** -- Who the client is, what your company does for them, relationship context. One paragraph is fine to start.
- **Key Contacts** -- Client-side people you'll interact with. Name, title, role in the engagement.
- **Technology Landscape** -- What platforms they run (CMS, DAM, commerce, etc.). This becomes the reference for all future project scoping.
- **Active Projects** -- Leave empty until Step 3.

> [!tip] You can come back and fill these in incrementally. The hub note is a living document, not a one-time form.

## 3. Add First Project (If Known)

```
/new-project [client-name] "Project Name"
```

Example: `/new-project acme-corp "Content Engine RFP"`

This creates under `work/clients/[client-name]/projects/[project-name]/`:

- `[Project Name].md` -- Project hub note
- `project-instructions.md` -- Portable Claude.ai briefing (self-contained, no wikilinks in instructional text)
- `/files` -- Project-specific binaries
- `/meetings` -- Project-specific meetings

The command also links the project from the client hub note and updates the entity registry.

> [!tip] If you don't have a project yet, skip this step. You can run `/new-project` later when work kicks off.

## 4. Ingest First Meeting

```
/ingest-meeting [transcript or file path]
```

Examples:
- `/ingest-meeting /intake/meetings/granola/2026-03-30-acme-kickoff.md` -- Process a Granola-synced file
- `/ingest-meeting [paste raw transcript]` -- Process pasted text

The command will:
1. Detect the client and project from the transcript content
2. Structure the note with attendees, discussion points, decisions, and action items
3. Route it to the correct meetings folder (`work/clients/[client]/meetings/`)
4. Extract your action items to the daily note's Suggested Tasks section
5. Move the raw Granola file to `intake/meetings/granola/processed/`

## 5. Add Client Contacts to Entity Registry

If client-side people will be referenced in future notes, add them to the vault:

1. **Create person pages** under `people/clients/[client-name]/`. Each person gets a file named `First Last.md` with frontmatter (`type: person`).
2. **Add to entity registry** in `_meta/entities.md` under the People section. Include aliases if they go by shortened names.

> [!tip] Only create person pages for people you'll reference more than once. One-off meeting attendees can stay as plain text in meeting notes.

## 6. Verify Entity Registry

Open `_meta/entities.md` and confirm:

- The client appears in the **Clients** table with the correct folder path
- Any aliases are listed (e.g., `MH` for Meridian Health, `AG` for Redwood Co)
- If you ran `/new-project`, the project appears in the **Projects (Client-Specific)** table

This matters because all slash commands (`/ingest-meeting`, `/context-load`, `/new-project`) resolve entity names from this registry. A missing or misspelled entry means broken routing.

## 7. Set Up Claude.ai Project (If Needed)

For clients with ongoing deep work (RFPs, architecture, multi-month engagements):

1. Create a new project in Claude.ai
2. Copy the contents of `project-instructions.md` from the project folder into the project's custom instructions
3. The instructions file is self-contained -- no vault-specific references that won't resolve in Claude.ai

> [!tip] Not every client needs a Claude.ai project. Reserve this for engagements where you'll have extended conversations about the same context. One-off meetings or lightweight clients don't need it.

## Quick Reference

| Step | Command | When |
|------|---------|------|
| Scaffold client | `/new-client "Name"` | Always first |
| Add project | `/new-project [client] "Name"` | When work is defined |
| Ingest meeting | `/ingest-meeting [source]` | After any client meeting |
| Load context | `/context-load [client]` | Before deep work on the client |
| Sync instructions | `/sync-instructions [project]` | After updating project hub note |
