## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions.

---

Read the note at $ARGUMENTS and add wikilinks for all recognized entities.

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Read the Note

**With CLI:**
```bash
obsidian read path="$ARGUMENTS"
```

If `$ARGUMENTS` is a name rather than a path:
```bash
obsidian read file="$ARGUMENTS"
```

**Fallback:** Read via file I/O.

## Step 2: Load Entity Registry

Read `/_meta/entities.md`. Build a lookup of all canonical names and aliases:
- People (full names + short names: "Sam Okafor" / "Sam")
- Clients (official + aliases: "Meridian Health" / "MH")
- Projects (full + short: "Commerce Migration" / "Platform Migration")
- Technologies (canonical + common: "Adobe Commerce" / "Magento")
- Domains (as listed)

## Step 3: Match and Link

Scan the note content for entity matches. For each match:

**Rules:**
- Don't double-link — skip anything already in `[[brackets]]`
- Don't link inside code blocks, URLs, or frontmatter values
- Don't link the note's own title
- Use display aliases for readability: `[[Sam Okafor|Sam]]` when the original text used "Sam"
- Match longest first to avoid partial matches (e.g., "Adobe Commerce" before "Adobe")
- Case-insensitive matching, but preserve original casing in display alias

## Step 4: Preview Changes

Show all proposed changes before applying:

```
## Relink Preview: [Note Title]

**Entities found:** N matches

1. Sam → [[Sam Okafor|Sam]] (3 occurrences)
2. Acme Corp → [[Acme Corp]] (2 occurrences)
3. DAM → [[DAM]] (2 occurrences)
4. Ellis → [[Jordan Park]] (1 occurrence)
5. Magento → [[Adobe Commerce|Magento]] (1 occurrence)

Apply all? (y/n/pick by number)
```

## Step 5: Apply

On approval, write the updated content:

**With CLI:**
```bash
obsidian write path="$ARGUMENTS" content="[updated content]" overwrite
```

**Fallback:** Write via file I/O.

If the user picks specific changes, apply only those and leave the rest untouched.

Output a confirmation:

> [!success] Relinked [[Note Title]]
> Added N wikilinks across N entities.
