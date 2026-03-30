## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Create a bridge note for a newly symlinked code project.

1. Read the code project at $ARGUMENTS inside the vault's /code directory
   (e.g., /bridge code/[company]/clients/microsoft/dam-research)
2. Find and read all markdown files in the project (README, docs/, etc.)
3. Identify the client, domain, and project from the code path structure:
   - /code/[company]/clients/[client]/[project] → client project
   - /code/[company]/internal/[domain]/[project] → internal project
   - /code/personal/[project] → personal project
4. Check /_meta/entities.md for matching entities
5. Generate a bridge note with:
   - Proper frontmatter (type, client, project, domain, status, date)
   - Summary of what the codebase does (from README and docs)
   - Key technical details (stack, architecture, dependencies)
   - Links to all discovered doc files using [[wikilinks]]
   - Wikilinks to all recognized entities (clients, technologies, domains)
   - A "Code Docs" section listing every markdown file found with a one-line description
   - An "Architecture" section if architecture docs exist
   - Connections to related vault notes (other projects, domain notes)

6. Save the bridge note to the appropriate location:
   - Client project → /work/clients/[client]/[project-name]-code.md
   - Internal project/initiative → resolved from entity registry (e.g., /work/[company]/projects/[project-name]/ or /work/[company]/initiatives/[initiative]/projects/[project-name]/)
   - Personal project → /domains/[relevant-domain]/[project-name]-code.md

7. Update the relevant hub note (client hub or project hub) to reference the new bridge note

8. If the entity registry is missing any technologies or tools found in the codebase,
   list them and suggest additions to /_meta/entities.md

This bridge note connects a code project's documentation to the vault's knowledge graph
without modifying any files in the code project itself.
