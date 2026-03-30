## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Scan daily notes from the past 14 days. Look for:

1. Anything tagged #idea
2. Substantial observations (more than a throwaway line)
3. Recurring themes that appear in multiple daily notes
4. Technical insights or architecture thinking worth preserving

For each candidate:
- Extract the core idea
- Add context from the surrounding daily note
- Find connections to existing notes in the vault
- Create a standalone note with proper frontmatter and [[wikilinks]]

## Routing

**Direct route when the home is obvious.** If an idea clearly belongs in a domain or project, save it there:
- Technical insight about RAG pipelines → `/domains/ai-ml/`
- Observation about creative production workflows → `/domains/creative-ops/`
- Architecture idea for a specific project → that project's folder
- Career-related reflection → `/domains/career/`

**Fall back to `/agent-output/graduated/`** only when the idea doesn't have a clear home — it spans multiple domains, it's too early to categorize, or it's genuinely novel.

## Stub Cleanup

Before graduating anything, scan `/agent-output` for empty or near-empty files (no content beyond frontmatter, or less than 10 characters of body text). These are ghost stubs — usually created when Obsidian auto-resolves a wikilink and creates a blank file.

For each stub found:
- Check if a real note with the same name exists elsewhere in the vault
- If yes: delete the stub (it's intercepting wikilink resolution from the real note)
- If no: flag it — "Empty stub `[[Name]]` exists with no real note. Delete or create a real note?"

Report stubs cleaned/flagged in the receipt.

## Output

After processing, output a receipt:

```
## Graduated

**Scanned:** N daily notes (date range)
**Promoted:** N ideas

1. "Idea title" → saved to /domains/ai-ml/idea-title.md (connected to [[RFP Engine]], [[pgvector]])
2. "Idea title" → saved to /agent-output/graduated/idea-title.md (no clear home yet)
3. [skipped] "Half-formed thought" — not substantial enough yet

**Stubs cleaned:** N empty files removed from /agent-output (or "None found")
**Suggested connections:** [[Entity]] hub note could reference #1 (y/n)
```
