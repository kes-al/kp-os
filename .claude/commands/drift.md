## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions.

---

Scan the vault for recurring themes or phrases that appear across unrelated notes — different clients, different domains, different time periods.

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Tag Frequency Analysis

**With CLI:**
```bash
obsidian tags sort=count counts
```

This gives a ranked list of all tags and how often they appear. Look for:
- Tags with high counts that aren't obvious structural tags (not `#idea`, not type tags)
- Tags that appear across multiple folder domains (work + personal, multiple clients)

## Step 2: Daily Note Pattern Scan

**With CLI:**
```bash
obsidian search query="[candidate-theme]" path=daily-notes limit=50
```

For promising themes from Step 1, search daily notes specifically to see how often they come up in daily thinking vs. just project documentation.

Also scan for recurring language patterns:
```bash
obsidian search query="I keep" path=daily-notes limit=20
obsidian search query="should we" path=daily-notes limit=20
obsidian search query="what if" path=daily-notes limit=20
obsidian search query="frustrated" path=daily-notes limit=20
obsidian search query="excited" path=daily-notes limit=20
```

**Fallback (file I/O):**
```bash
grep -rc "[theme]" daily-notes/ --include="*.md" | sort -t: -k2 -rn
```

## Step 3: Cross-Domain Detection

**With CLI:**
```bash
obsidian search query="[theme]" limit=50
```

For each candidate theme, check which folders/domains the results span. A theme that appears in `/work/clients/acme-corp/`, `/work/clients/meridian-health/`, AND `/domains/ai-ml/` is a genuine cross-cutting drift — more interesting than one confined to a single project.

## Step 4: Entity Registry Gap Check

Read `/_meta/entities.md`. For each recurring theme found, check if it's already a registered entity. Themes that keep appearing but aren't in the registry are the most interesting drift signals — they're concepts the vault is developing organically without explicit structure.

## Step 5: Output

Output the analysis directly in the conversation.

For each theme found:
- **Theme:** what the pattern is
- **Evidence:** which notes (with `[[wikilinks]]` and dates)
- **Frequency:** how often, across how many domains/clients
- **Interpretation:** what might this mean about where my thinking is heading?
- **Alignment check:** is this theme reflected in any active project? If not, flag the gap: "You keep circling back to X but it's not in any active project — should it be?"
- **Suggested action:** should this become a project, a domain note, or an investigation?

## Follow-up

For any theme that looks project-ready, offer to scaffold:
- "This theme has enough substance for a project. Want me to run `/new-project` to set it up?"
- "This should probably be a domain note. Want me to create one in /domains/[relevant]/?"

For themes that are just emerging, offer to add a task:
- "Want me to add 'Investigate [theme]' to your daily note?"

## Backlog Check

After the drift analysis, read `/_meta/vault-backlog.md`. If any drift themes connect to backlog items, mention it: "This theme aligns with [backlog item] — might be time to act on it."

## Archival

Save to `/agent-output/drift/drift-report-[date].md` using `obsidian create` (or file I/O fallback).
