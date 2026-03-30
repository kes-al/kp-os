## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scaffold a new code project entry under a vault project.

$ARGUMENTS should be: [project-path] [repo-name] [repo-url]
Example: /new-code acme-corp/projects/rfp rfp-engine https://github.com/yourorg/rfp-engine

1. Verify the project exists under /work
2. Create a /code subfolder in the project if it doesn't exist
3. Create a code note with:
   - Proper frontmatter (type: code, client, project, status: active, date)
   - Repo URL
   - Stack/technologies (ask if not obvious)
   - Vault symlink path (where it would live under /code/)
   - Wikilink to the parent project
4. Check if a symlink exists at the expected vault symlink path
   - If YES: run bridge analysis (read all markdown files in the repo, summarize architecture and docs) and append to the code note
   - If NO: add a reminder with the exact symlink command needed, e.g.:
     `ln -s /path/to/repo/docs ~/Desktop/personal/vault/code/[company]/clients/[client]/[project]`
5. Update the project hub note with a ## Codebases section linking to the new code note
6. If the entity registry is missing any technologies found, suggest additions to /_meta/entities.md
