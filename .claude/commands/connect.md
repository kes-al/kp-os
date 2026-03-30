## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions.

---

Find connections between the topics specified in $ARGUMENTS in the vault.
Arguments should be two topics separated by "and" (e.g., /connect commerce and DAM)

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Parse Topics

Split $ARGUMENTS on "and" to get Topic A and Topic B. For each topic, resolve against `/_meta/entities.md` for canonical names and aliases.

## Step 2: Search for Each Topic

**With CLI:**
```bash
# Topic A — search + backlinks
obsidian search query="[topicA]" limit=50
obsidian search query="[topicA-alias]" limit=50
obsidian backlinks file="[TopicA Note]"

# Topic B — search + backlinks
obsidian search query="[topicB]" limit=50
obsidian search query="[topicB-alias]" limit=50
obsidian backlinks file="[TopicB Note]"
```

**Fallback (file I/O):**
```bash
grep -rl "[topicA]\|[aliasA]" --include="*.md" . > /tmp/topicA_notes.txt
grep -rl "[topicB]\|[aliasB]" --include="*.md" . > /tmp/topicB_notes.txt
```

## Step 3: Find Intersections

- **Direct connections:** notes that appear in BOTH topic searches (set intersection)
- **Shared tags:** use `obsidian tags` on notes from each set, find overlap
- **Indirect paths:** for notes in Topic A's set, check if they link to anything in Topic B's set (one hop). Use `obsidian backlinks` on key nodes to trace the chain.

## Step 4: Read and Analyze

Read the intersection notes and any interesting indirect-path notes. For each, extract what it says about both topics and why the connection matters.

## Step 5: Output

Output the analysis directly in the conversation:

- **Direct connections** — notes that mention both, with `[[wikilinks]]` and what they say
- **Indirect paths** — the chain of links between them (A → C → B)
- **Shared context** — common tags, clients, domains, people
- **Potential synergies:** what insight comes from seeing these together?
- **Suggested actions:** anything worth exploring based on this connection?

## Follow-up

If the connection reveals something actionable, suggest specific updates:
- "This connection suggests [[Entity A]] and [[Entity B]] should reference each other. Want me to add cross-links to both hub notes?"
- "There's a pattern here that could become a domain note. Want me to create one in /domains/[relevant]?"

Don't auto-write — ask first.

## Archival

Save to `/agent-output/connections/[topicA]-[topicB]-[date].md` using `obsidian create` (or file I/O fallback).
