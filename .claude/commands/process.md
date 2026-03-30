## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Make a note vault-native. Process the current note (or the note at `$ARGUMENTS` if a path is provided) and bring it up to vault standards.

If no argument is provided, ask which note to process — or if running in Obsidian's embedded terminal, process the currently open file.

## Step 1: Read and Assess

Read the note and evaluate what needs work:
- Does it have frontmatter? Is the frontmatter complete?
- Are there entities that should be wikilinked?
- Are there tasks that need proper formatting?
- Are there ideas that should be tagged?
- Is the note in the right location?

## Step 2: Wikilink Entities

Scan the note content against `/_meta/entities.md` (including aliases). Wrap every recognized entity in `[[wikilinks]]`:
- People: `Sam` → `[[Sam Okafor|Sam]]`
- Clients: `MH` → `[[Meridian Health]]`
- Projects: `the RFP engine` → `the [[RFP Engine]]`
- Technologies: `Magento` → `[[Adobe Commerce|Magento]]`
- Domains: `DAM` → `[[DAM]]`

**Rules:**
- Don't double-link (if already wrapped in `[[]]`, skip)
- Use display aliases for readability: `[[Sam Okafor|Sam]]` not `[[Sam Okafor]]` when the original text used the short name
- Don't link inside code blocks, URLs, or frontmatter values
- Don't link the note's own title

## Step 3: Fix Frontmatter

If frontmatter is missing, generate it based on the note's content and location:

```yaml
---
title: [from filename or first heading]
type: [infer: note, meeting, decision, project, etc.]
client: [if detectable from content or path]
project: [if detectable from content or path]
domain: [if detectable from content or path]
status: active
date: [from file creation date or today]
tags: []
---
```

If frontmatter exists but is incomplete:
- Fill in missing fields that can be inferred (don't guess — only add what's clear from content or file path)
- Don't overwrite existing values
- Flag fields that look wrong: "Frontmatter says `client: acme-corp` but the note only discusses [[Meridian Health]]. Update? (y/n)"

## Step 4: Format Tasks

Find anything that looks like a task or action item and convert to proper inline format:
- `- TODO: send Ellis the deck` → `- [ ] ❗ 2026-02-28 Send [[Jordan Park]] the deck`
- `- need to follow up with Sam` → `- [ ] 2026-02-27 Follow up with [[Sam Okafor|Sam]]`
- `- [ ] send the thing by friday` → `- [ ] 2026-02-28 Send the thing` (resolve relative dates)

**Rules:**
- Default to regular priority unless context suggests urgency
- Default date to tomorrow if none mentioned
- Resolve relative dates ("friday", "next week", "end of month") to actual dates
- Don't touch tasks that are already properly formatted
- Don't convert lines that are clearly observations, not commitments

## Step 5: Tag Ideas

Scan for speculative or half-formed thoughts:
- Lines starting with "maybe", "what if", "I wonder", "could we", "idea:"
- Questions that aren't directed at someone specific
- Observations with a speculative tone

Append `#idea` to these lines if not already tagged.

## Step 6: Location Check

Based on the note's content and frontmatter, check if it's in the right place:
- A note about [[Acme RFP]] sitting in `/agent-output` → suggest moving to `/work/clients/acme-corp/projects/rfp/`
- A domain note in the wrong domain folder → suggest the right one
- A meeting note not in a meetings folder → suggest the right location

Don't auto-move. Suggest with the exact path.

## Output

Show all changes as a diff-style preview before applying:

```
## Process Note: [Note Title]

**Wikilinks added:** 8 entities linked
  - Sam → [[Sam Okafor|Sam]] (3 occurrences)
  - Acme Corp → [[Acme Corp]] (2 occurrences)
  - DAM → [[DAM]] (2 occurrences)
  - Ellis → [[Jordan Park]] (1 occurrence)

**Frontmatter:** Added missing `client: acme-corp`, `project: rfp`

**Tasks formatted:** 2
  - "send Ellis the deck by Friday" → `- [ ] ❗ 2026-02-28 Send [[Jordan Park]] the deck`
  - "follow up with Sam on timeline" → `- [ ] 2026-02-27 Follow up with [[Sam Okafor|Sam]] on timeline`

**Ideas tagged:** 1
  - "maybe we should lead with the DAM story instead" → added #idea

**Location:** ⚠️ Note is in /agent-output but looks like it belongs in /work/clients/acme-corp/projects/rfp/. Move? (y/n)

Apply all changes? (y/n/pick)
```

**Controls:**
- **y** — apply everything
- **n** — cancel
- **pick** — show numbered list, apply only selected changes

## Rules

- Never modify the note without showing the preview first
- Preserve the author's voice — fix formatting, not prose
- When in doubt about whether something is a task, leave it as-is
- Don't over-tag with #idea — only genuinely speculative lines
- If the note is already vault-quality, say so: "This note looks good. No changes needed."
