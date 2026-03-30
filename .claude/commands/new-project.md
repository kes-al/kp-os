## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scaffold a new project under any parent entity (client, internal project, or internal initiative).

$ARGUMENTS should be in the format: [parent-entity] "Project Name" [optional: alias1, alias2]
(e.g., /new-project eastgate "Security Audit")
(e.g., /new-project [company] "AI Academy")
(e.g., /new-project commerce "UX Review" — creates under commerce initiative)
(e.g., /new-project health "Compliance Review" MLR, DataTonic)

## Steps

1. **Parse arguments.** Extract parent entity name, project name, and optional aliases.

2. **Resolve parent path from entity registry.** Look up the parent entity in `/_meta/entities.md`:
   - If it's a client → base path is `work/clients/[client-folder]/projects/`
   - If it's a internal entity (tag, an internal project like "health", or a internal initiative like "commerce") → base path is the entity's folder + `/projects/`
   - If the parent entity is not found → stop and ask. Don't guess.

3. **Generate project folder name.** Lowercase, hyphenated from project name (e.g., "Security Audit" → `security-audit`).

4. **Check for conflicts.** If the project folder already exists, stop and report it.

5. **Scaffold folder structure:**
   ```
   [parent-path]/[project-folder]/
     [Project Name].md        ← Project hub note
     project-instructions.md  ← Claude.ai briefing (portable, self-contained)
     /files                   ← Project-specific binary files
     /meetings                ← Project-specific meeting notes
   ```

6. **Generate the project hub note:**

```markdown
---
title: [Project Name]
type: project
project: [project-folder-name]
client: [client-folder-name if applicable]
status: active
date: [today YYYY-MM-DD]
tags: []
---

# [Project Name]

## Overview


## Current State


## Goals


## Architecture / Approach


## Team


## Timeline


## Active Tasks


## Notes & Links


## Decision Log
```

   - Include `client:` field only if the parent is a client (not for internal).

7. **Generate the project-instructions note** (`project-instructions.md` in the project folder):

   Use the template at `/templates/project-instructions.md`. Replace all template variables:
   - `{{project_name}}` → Project Name
   - `{{project_folder}}` → project-folder-name
   - `{{client_folder}}` → client-folder-name (or remove the `client:` field for internal)
   - `{{project_path}}` → full relative path from vault root (e.g., `work/clients/eastgate/projects/security-audit`)
   - `{{date:YYYY-MM-DD}}` → today's date

   Populate the **Project Summary** section with a one-liner: "New project — summary to be filled after kickoff."
   
   Populate the **Key People** section with the user as project lead. If the parent is a client, add a placeholder for the client-side contact.

   Populate the **Project File Paths** section with the actual paths.

   Leave all other sections with their template comments for the user to fill in.

   > This note is what gets copy-pasted into the corresponding Claude.ai project's custom instructions. It must be self-contained — no wikilinks in instructional text, only in the vault content conventions section where they're being taught.

8. **Update entity registry** (`/_meta/entities.md`):
   - Add to "Projects (Client-Specific)" or "Projects (Internal)" table as appropriate.
   - Include aliases if provided.
   - Format: `| [[Project Name]] | [full-path] | alias1, alias2 |`

9. **Update parent hub note:**
   - For clients: add `- [[Project Name]]` under `## Active Projects` in the client hub note.
   - For internal: add `- [[Project Name]]` under the appropriate section in the parent hub note.

10. **Update CLAUDE.md:**
   - Add the new project to the Entity Registry Reference section under the appropriate subsection.
   - If the project creates a new structural pattern (e.g., nested sub-projects), update the Vault Structure section.

11. **Update project-instructions.md** (`/_meta/project-instructions.md`):
    - Add the new project to the Entity Quick Reference section.
    - Update the Active Projects list.

12. **Add kick-off task to today's daily note:**
    - Find today's daily note (most recent with empty `## End of Day`).
    - Read the file first, then append to the `## Active Tasks` section:
      `- [ ] 📅 [today] Define scope and next steps for [[Project Name]] 🔼`

13. **Print receipt:**
    ```
    ✅ Created project: [[Project Name]]
    📁 Location: [full path]
    📝 Hub note: [Project Name].md
    📋 Project instructions: project-instructions.md
    🏷️ Aliases: [aliases or "none"]
    📋 Entity registry: updated
    📄 CLAUDE.md: updated
    📄 /_meta/project-instructions.md: updated
    🔗 Parent hub: [[Parent Name]] updated
    ✅ Task added to [[YYYY-MM-DD]] daily note
    ```

## Rules

- **Always resolve paths from the entity registry.** Never hardcode or guess folder paths.
- **Read before writing.** Especially daily notes and hub notes — they may have existing content.
- **If parent entity not found**, stop and suggest: "I can't find '[name]' in the entity registry. Did you mean [closest match]? Or should I run `/new-client [name]` first?"
- **Aliases are optional** but encouraged. Ask if none provided: "Any aliases for this project? (e.g., short names, acronyms, alternative references). Press enter to skip."
