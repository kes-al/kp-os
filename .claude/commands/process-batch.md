## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Process multiple raw notes from `/intake/notes/` in sequence.

This is the notes-specific batch processor. For sweeping all of `/intake` (meetings + notes + clips), use `/triage` instead.

If `$ARGUMENTS` is provided, use as a date filter ("today", "yesterday", "this week", or a specific date). Otherwise, process all unprocessed notes.

## Step 1: Find Unprocessed Notes

Scan `/intake/notes/` for files that need processing:
- Missing proper frontmatter
- No wikilinks present
- `status: draft` in frontmatter

## Step 2: Present the Queue

```
## Notes Queue

Found N unprocessed notes in /intake/notes/:

1. "DAM integration thoughts" (detected: [[DAM]], [[Acme Corp]])
2. "Quick note on Sam feedback" (detected: [[Sam Okafor]])
3. "Untitled" (no entities detected)
4. "Commerce platform comparison" (detected: [[Commerce]])

Process all? (y/pick numbers/stop)
```

## Step 3: Process Each Note

Run the full `/process` pipeline on each:
1. Wikilink all entities
2. Add/fix frontmatter
3. Format tasks
4. Tag ideas
5. Suggest permanent location
6. Show preview, apply on approval
7. Move to permanent location if approved

Pause between notes for approval.

## Step 4: Batch Summary

```
## Notes Batch Complete

**Processed:** N of N notes
**Moved to permanent homes:** N
  - "DAM integration thoughts" → /domains/dam/dam-integration-thoughts.md
  - "Sam feedback" → /work/[company]/admin/team/sam-okafor/feedback-note.md
**Still in intake:** N (no clear home)
**Tasks extracted:** N added to daily note
```

## Rules

- Full `/process` treatment for each note. No shortcuts.
- Notes that get routed leave `/intake/notes/`. The folder should trend toward empty.
- Notes with no clear home stay in `/intake/notes/` with improved formatting. Easier to route next time or during `/triage`.
