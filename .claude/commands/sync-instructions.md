## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format

---

Re-derive a project's `project-instructions.md` from its current hub note state. This is how you keep the Claude.ai briefing in sync after the hub note evolves.

$ARGUMENTS should be a project name, alias, or folder name.
(e.g., /sync-instructions commerce)
(e.g., /sync-instructions "Meridian RFP")
(e.g., /sync-instructions bottler-summit)

## Steps

1. **Resolve the project from the entity registry.** Look up $ARGUMENTS in `/_meta/entities.md` — match against entity names, folder names, and aliases. If no match, stop and suggest the closest match.

2. **Read the hub note.** The hub note is the Title Case `.md` file in the project folder (e.g., `Commerce.md`, `Meridian RFP.md`, `Summit Kickoff.md`). Read it fully.

3. **Read the existing `project-instructions.md`** in the same folder, if it exists. If it doesn't exist, use the template at `/templates/project-instructions.md` as the starting point and note this in the receipt.

4. **Read the obsidian-markdown skill** at `/.claude/skills/obsidian-markdown/SKILL.md` to confirm the formatting directive is accurate. Don't embed the full skill — just verify the path and key rules haven't changed.

5. **Determine the parent entity.** From the folder path, figure out if this is a client project or internal:
   - `work/clients/[client]/projects/[project]` → client project. Extract client name from the client hub note.
   - `work/[company]/projects/[project]` → internal.
   - `work/[company]/initiatives/[initiative]/projects/[project]` → internal initiative sub-project.

6. **Re-derive each section** of `project-instructions.md`:

   **Title & frontmatter:** Update `date` to today if creating new; preserve original `date` if updating. Always set `updated` to today.

   **Project Summary:** Rewrite from the hub note's `## Overview` and `## Current State` sections. 2-3 paragraphs, self-contained. No wikilinks — flatten all `[[references]]` to plain text. If the hub note sections are empty/placeholder, note "Summary to be filled — hub note Overview/Current State sections are empty."

   **Key People:** Extract from hub note's `## Team` section. Flatten wikilinks to plain text with roles. Always include the user as project lead. If the hub note has no team section or it's empty, keep the user and add a placeholder.

   **How We Work:** This section is mostly static (conventions don't change per-project). Preserve it from the existing file. If creating new, use the template defaults.

   **Vault Access & Formatting:** This section is static — the skill file path and vault path don't change. Preserve from existing file or template. Verify the skill path is still `/.claude/skills/obsidian-markdown/SKILL.md`.

   **Project File Paths:** Update from the resolved entity registry path. Include hub note path, meetings folder, files folder, agent-output.

   **Active Workstreams:** Derive from hub note's `## Active Tasks`, `## Current State`, and `## Goals` sections. Summarize the current threads of work in 3-8 bullet points. Flatten wikilinks to plain text.

   **Relevant Entities:** Scan the hub note for wikilinked entities. Cross-reference against `/_meta/entities.md` to categorize them (clients, people, technologies, related projects). List only what's relevant to this project.

   **Decision Log:** Pull from hub note's `## Decision Log` or `## Notes & Links` sections. Flatten wikilinks. If empty, preserve template placeholder.

7. **Write the updated file.** Write to `[project-folder]/project-instructions.md`. If the file already exists, overwrite it entirely — this is a full re-derive, not a merge.

8. **Print receipt:**
   ```
   🔄 Synced: [Project Name] project-instructions.md
   📁 Location: [full path to project-instructions.md]
   📝 Source: [Project Name].md (hub note)
   📊 Sections updated:
     - Project Summary: [derived / empty — hub note needs content]
     - Key People: [N people listed]
     - Active Workstreams: [N items]
     - Relevant Entities: [N entities]
     - Decision Log: [N decisions / empty]
   ⏱️ Hub note last modified: [file mod date if available]
   
   ⚠️ Copy this file's contents into the Claude.ai project instructions for [[Project Name]].
   (Requires Claude desktop app — MCP/Filesystem not available on claude.ai web.)
   ```

## Rules

- **Always resolve paths from the entity registry.** Never hardcode or guess folder paths.
- **Flatten all wikilinks in output.** The project-instructions note must be self-contained — Claude.ai can't resolve `[[wikilinks]]`, so convert them to plain text. Exception: the "How We Work" section teaches wikilink conventions, so those are fine as examples.
- **Preserve static sections.** "How We Work" and "Vault Access & Formatting" rarely change. Pull from existing file if it exists, template if it doesn't.
- **Don't invent content.** If the hub note sections are empty, say so in the output. Don't fill in guesses.
- **Read the hub note fresh every time.** Don't rely on cached or remembered content. The whole point is to re-derive from current state.
- **This is a full overwrite, not a merge.** The project-instructions file is a derived artifact. It gets regenerated from the hub note, not incrementally edited.
