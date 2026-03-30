## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Stage all changes in the vault git repo. Review what's changed.
Generate a descriptive commit message based on the modified files.
Commit and push.

## Stub Check

Before committing, scan `/agent-output` for empty or near-empty files (files with no content beyond frontmatter or less than 10 characters of body text). These are usually ghost stubs created by Obsidian auto-resolving wikilinks.

If stubs are found:
- List them with their file sizes
- Check if a real note with the same name exists elsewhere in the vault (a stub may be stealing wikilink resolution from the real note)
- Recommend deletion: "These empty stubs should be deleted — they may be intercepting wikilinks meant for real notes elsewhere in the vault."
- Delete them automatically as part of the commit, and include "cleaned up N empty stubs from agent-output" in the commit message.
