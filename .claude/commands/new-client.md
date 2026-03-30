## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scaffold a new client folder structure.

1. Take $ARGUMENTS as the client name (e.g., /new-client "Acme Corp")
2. Generate a lowercase, hyphenated folder name (e.g., acme-corp)
3. Create the following directory structure:
   /work/clients/[folder-name]/
     [Client Name].md          ← Client hub note
     /files                    ← Client-level binary reference files
     /meetings                 ← Client-level meeting notes
     /projects                 ← Client-specific projects (empty to start)

4. Generate the client hub note with this exact format:

---
title: [Client Name]
type: client
client: [folder-name]
status: active
date: [today's date YYYY-MM-DD]
---

# [Client Name]

## Overview


## Active Projects


## Key Contacts


## Technology Landscape


## History


## Meeting Notes


## Reference Files
<!-- The /files subfolder holds client-level binary reference materials -->
<!-- Project-specific files go in /projects/[name]/files -->

## Resources


5. Add the new client to /_meta/entities.md in the Clients table
6. Add the new client to /work/clients/Clients.md (create this file if it doesn't exist)

7. Confirm what was created and remind to add any known aliases to the entity registry.
