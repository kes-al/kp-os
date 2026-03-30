## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scaffold a new domain or retrofit an existing flat domain with structure.

## Step 1: Parse Arguments

Take `$ARGUMENTS` as the domain name (e.g., `/new-domain Prototyping`, `/new-domain "AI/ML"`).

- Generate a lowercase-hyphenated folder name (e.g., `prototyping`, `ai-ml`)
- Generate a Title Case display name (e.g., `Prototyping`, `AI/ML`)

## Step 2: Check for Existing Domain

Check if `/domains/[folder-name]/` already exists.

**If it exists:**
- Read all files currently in the folder
- Check if a hub note (`[Domain Name].md`) already exists
- If hub note exists, read it and report what's already there — don't overwrite
- If no hub note, create one (Step 3)
- Ensure `/files` subfolder exists
- Report what was retrofitted vs. what was already in place

**If it doesn't exist:**
- Create the folder structure (Step 3)

## Step 3: Create Structure

```
/domains/[folder-name]/
  [Domain Name].md          — Hub note (knowledge landscape, links, POV)
  /files                    — Binary references (PDFs, exports). Not in git.
```

Synthesis and research notes accumulate in the root alongside the hub note over time. They are NOT created at scaffold time — they emerge from `/capture`, `/process`, research sessions, and manual work.

## Step 4: Generate Hub Note

Create the hub note with this format:

```markdown
---
title: [Domain Name]
type: note
domain: [folder-name]
status: active
date: [today YYYY-MM-DD]
tags:
  - domain
  - [folder-name]
---

# [Domain Name]

## Landscape

<!-- What does this domain cover? Key players, tools, trends, your POV. -->


## Key Links

<!-- Curated external links — articles, docs, tools, repos. -->


## Open Questions

<!-- What are you trying to figure out? What's unresolved? -->


## Connected Work

<!-- Wikilinks to clients, projects, people where this domain is active. -->


## Research

<!-- Links to synthesis notes in this folder as they accumulate. -->


## Reference Files

<!-- The /files subfolder holds binary reference materials (PDFs, exports, screenshots). -->
```

## Step 5: Update Entity Registry

Add or update the domain in `/_meta/entities.md` under the `## Domains` table:

```
| [[Domain Name]] | domains/[folder-name] | alias1, alias2 |
```

**Ask the user for aliases** — these are critical for routing. When `/ingest-meeting` or `/triage` encounters these terms, they'll route content to this domain. Good aliases include:
- Alternate names (e.g., "GenAI" for AI/ML)
- Key subtopics that should route here (e.g., "guardrails" for Prototyping)
- Abbreviations people use in meetings

If retrofitting an existing domain, check if it's already in the entity registry. Update aliases if needed but don't duplicate the row.

## Step 6: Confirm

Output a receipt:

```markdown
> [!success] Domain Scaffolded
> **Domain:** [[Domain Name]]
> **Folder:** /domains/[folder-name]/
> **Hub note:** Created / Already existed
> **Entity registry:** Added / Updated / Already present
> **Aliases:** [list]
> **Existing content preserved:** [list any files that were already in the folder]
```

If this is a retrofit, also list:
- Files that were already in the folder (preserved, untouched)
- What was added (hub note, /files folder)

## Rules

- Never delete or overwrite existing content in the domain folder. Retrofit is additive only.
- The hub note is the landing page — it should link OUT to synthesis notes, not contain the synthesis itself.
- Synthesis notes are created by other commands (`/capture`, `/ghost`, `/research`) or manually — not by this command.
- `/files` folders hold binaries that aren't indexed by Obsidian or git. Don't reference their contents.
- Aliases in the entity registry are what power routing. Bad aliases = content goes to `/agent-output` instead of the domain. Be specific enough to avoid false matches (e.g., "health" as an alias is too broad if it could match client work).
