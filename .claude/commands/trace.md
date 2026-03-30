## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions.

---

Trace the concept of $ARGUMENTS across the Obsidian vault.

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to file I/O (grep/find across vault files). Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Resolve the Topic

Read `/_meta/entities.md` and find all names and aliases for the topic. Build a search list:
- Canonical name (e.g., "Commerce Migration")
- All aliases (e.g., "Platform Migration", "commerce")
- Related terms if obvious (e.g., "Adobe Commerce", "Magento")

## Step 2: Search

**With CLI:**
```bash
obsidian search query="[topic]" limit=50
obsidian search query="[alias1]" limit=50
obsidian search query="[alias2]" limit=50
obsidian backlinks file="[Topic Note]"
```

Deduplicate results across all searches.

**Fallback (file I/O):**
```bash
grep -rl "[topic]\|[alias1]\|[alias2]" --include="*.md" .
```

## Step 3: Read and Analyze

For each discovered note, read it (via `obsidian read path="..."` or file I/O) and extract:
- Date (from frontmatter)
- What was said about the topic (relevant excerpts)
- What other entities appear alongside it

Sort chronologically by frontmatter date.

## Step 4: Output

Output the timeline directly in the conversation:

- **First appearance:** when and where this topic first showed up
- **Evolution:** how the thinking changed over time, with dates and note references
- **Current state:** the most recent notes and where the thinking stands now
- **Connections:** what other topics, clients, or projects this links to
- **Time span:** how long this idea has been developing

Reference specific notes with `[[wikilinks]]` throughout.

## Follow-up

If the trace reveals an interesting evolution worth preserving as a standalone note, suggest it:
- "This trace shows your thinking on X has shifted significantly over N months. Want me to create a summary note in /domains/[relevant-domain]/?"

Don't auto-create — ask first.

## Archival

If the trace is substantial, also save to `/agent-output/traces/[topic]-[date].md` using `obsidian create` (or file I/O fallback). Mention at the end.
