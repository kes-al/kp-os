## Skills Reference

Before executing, load these skills for best practices:
- `obsidian-markdown` — Frontmatter format, wikilink syntax, callout types, task checkbox format
- `obsidian-cli` — CLI command syntax and patterns

All generated markdown must follow the obsidian-markdown skill conventions: proper YAML frontmatter, `[[wikilinks]]` for internal vault references (never markdown links for internal notes), `[text](url)` for external URLs only, callouts for highlighted information.

---

Process a natural language input and route it to the right place in the vault.

$ARGUMENTS

## CLI Check

```bash
obsidian version
```

If unavailable, fall back to file I/O. Log:

> [!warning] Obsidian CLI unavailable — using direct file operations.

---

## Step 1: Detect Type

Check if $ARGUMENTS starts with an explicit type prefix:

- `task ...` → **Task**
- `idea ...` → **Idea**
- No prefix → **Infer** from language:
  - Sounds like a commitment, follow-up, action item, or uses verbs like "need to", "follow up", "send", "schedule", "review" → **Task**
  - Speculative, half-formed, uses "maybe", "what if", "I wonder", "could we", "what about" → **Idea**
  - Everything else → **Observation** (context, intel, status update, something that happened)

If the inference is ambiguous, default to **Observation**. The user can promote later.

## Step 2: Enrich

Regardless of type, enrich the raw input:

1. **Entity matching:** Read `/_meta/entities.md`. Match every person, client, project, technology, and domain. Wrap in `[[wikilinks]]` using canonical names with display aliases where the user used a short name (e.g., "Sam" → `[[Sam Okafor|Sam]]`).

2. **Type-specific formatting:**

   **Task:**
   - Format: `- [ ] YYYY-MM-DD Description with [[wikilinks]] 🔼 ^t-MMDD-NNN`
   - Always append a block ID. Scan today's daily note for existing `^t-MMDD-NNN` IDs, find the highest NNN, increment.
   - If no date mentioned, default to tomorrow
   - If urgency is obvious ("urgent", "asap", "blocker", "today"), use `❗` (high priority)
   - Otherwise default to `🔼` (medium priority)
   - Preserve the user's phrasing — clean up for clarity but keep the voice

   **Idea:**
   - Append `#idea` tag
   - Add `[[wikilinks]]` for any entities mentioned
   - Keep it loose — don't over-structure ideas

   **Observation:**
   - Add `[[wikilinks]]` for all entities
   - Preserve the user's voice — this is context, not a polished note

## Step 3: Write to Daily Note

**Create today's daily note if it doesn't exist:**

With CLI:
```bash
obsidian daily:create silent
```

Fallback: Copy `/templates/daily-note.md` to `/daily-notes/YYYY-MM-DD.md`.

**Read the current daily note:**

With CLI:
```bash
obsidian daily:read
```

Fallback: Read via file I/O.

**Append to the correct section:**

- **Task** → `## Tasks` > `### Work` (this is a deliberate capture — Tasks, not Suggested)
- **Idea** → `## Ideas`
- **Observation** → `## Work Log`

Read the daily note, find the target section header, insert the content at the end of that section (before the next `##` header). Write back with `obsidian write` or file I/O.

## Step 4: Suggest Secondary Routing

After writing to the daily note, check if the input references entities with their own notes:

- A **client** with a hub note → suggest appending context
- A **project** with a project note → suggest appending relevant details
- A **person** (especially direct reports under `/work/[company]/admin/team/`) → suggest logging the interaction

Use CLI to verify the notes exist:
```bash
obsidian search query="[entity name]" limit=5
```

**Don't auto-write to secondary locations.** List suggestions with what you'd write, ask: "Want me to update any of these?"

**Skip secondary routing for Ideas** — ideas are loose by nature. `/graduate` handles routing them later.

## Step 5: Receipt

Output a receipt using callout format:

> [!success] Captured
> **Type:** Task / Idea / Observation
> **Written to:** [[YYYY-MM-DD]] → [section name]
> **Content:** [what was written, showing wikilinks]
> **Suggested updates:** [list entity notes, or "None"]

## Rules

- Never create new files outside the daily note. If something doesn't have a home, it lives in the daily note and `/graduate` handles it later.
- Preserve the user's voice — don't over-formalize. Clean up for clarity but keep the tone.
- `/capture` tasks go to **Tasks** > **### Work** because the user is deliberately capturing them. This is different from `/ingest-meeting` which puts extracted tasks in **Suggested Tasks** for review.
- One capture = one type. If the input contains both a task and an idea, split them and write each to the appropriate section. Note in the receipt: "Split into N items."
- If you truly can't tell what type something is, default to Observation in Work Log.

## Examples

**Input:** `/capture task Follow up with Sam on the Meridian timeline risk`

**Writes to Tasks > Work:**
`- [ ] 2026-02-28 Follow up with [[Sam Okafor|Sam]] on the [[Meridian RFP|Meridian]] timeline risk 🔼 ^t-0227-004`

> [!success] Captured
> **Type:** Task
> **Written to:** [[2026-02-27]] → Tasks > Work
> **Content:** `- [ ] 2026-02-28 Follow up with [[Sam Okafor|Sam]] on the [[Meridian RFP|Meridian]] timeline risk 🔼 ^t-0227-004`
> **Suggested updates:** Update [[Meridian RFP]] project note with timeline risk? (y/n)

---

**Input:** `/capture idea What if we used the vault's own graph data as input for the 3js knowledge visualization`

**Writes to Ideas:**
`- What if we used the vault's own graph data as input for the 3js knowledge visualization — [[Innovation Lab]] sprint candidate #idea`

> [!success] Captured
> **Type:** Idea
> **Written to:** [[2026-02-27]] → Ideas
> **Content:** What if we used the vault's own graph data as input for the 3js knowledge visualization — [[Innovation Lab]] sprint candidate #idea
> **Suggested updates:** None (ideas route via /graduate)

---

**Input:** `/capture Sam flagged a risk on the Meridian RFP timeline — they're waiting on Northstar pricing data before they can finalize the technical architecture section`

**Inferred type:** Observation (status update about what happened, no clear action verb directed at user)

**Writes to Work Log:**
`- [[Sam Okafor|Sam]] flagged a risk on the [[Meridian RFP]] timeline — they're waiting on [[Northstar]] pricing data before they can finalize the technical architecture section.`

**Also splits out a task (implicit follow-up):**
`- [ ] 2026-02-28 Follow up on [[Northstar]] pricing data for [[Meridian RFP]] technical architecture 🔼 ^t-0227-005`

> [!success] Captured
> **Type:** Observation + Task (split)
> **Written to:** [[2026-02-27]] → Work Log (observation) + Tasks > Work (follow-up)
> **Suggested updates:** Update [[Meridian RFP]] project note with timeline risk? (y/n)
