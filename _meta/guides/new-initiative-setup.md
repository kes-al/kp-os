---
title: New Initiative Setup
type: resource
date: 2026-03-30
tags: [guide, reference]
---

# New Initiative Setup

Step-by-step reference for scaffolding a new initiative in the vault.

## Initiative vs Project — When to Use Which

| | Initiative | Project |
|---|---|---|
| **Scope** | Broad strategic theme with multiple workstreams | Concrete, scoped deliverable |
| **Has sub-projects** | Yes — that's the whole point | No — it IS the project |
| **Location** | `work/[company]/initiatives/[name]/` | `work/[company]/projects/[name]/` or under a client |
| **Hub note type** | `type: initiative` | `type: project` |
| **Dataview query** | Auto-links child projects | None needed |
| **Examples** | Commerce, AI Strategy, Health Platform | RFP Engine, Hackathon, InfoSec Agents |

> [!tip] Rule of thumb
> If it will have sub-projects, it is an initiative. If it is a single scoped effort, it is a project. Projects can later be promoted to initiatives if they grow.

## Step 1: Scaffold the Initiative

Run the slash command:

```
/new-initiative "Initiative Name"
```

With optional aliases:

```
/new-initiative "Health Platform" Health, Life Sciences, HLS
```

This creates:

```
work/[company]/initiatives/[folder]/
  [Initiative Name].md    <- Hub note
  /files                  <- Binary reference files
  /meetings               <- Initiative-level meetings
  /projects               <- Sub-projects go here
```

The command also updates the entity registry (`_meta/entities.md`) and `CLAUDE.md`, and adds a kick-off task to today's daily note.

## Step 2: Fill In the Hub Note

Open the generated hub note and fill in three sections:

1. **Vision** — One paragraph. What is this initiative about strategically? What outcome are you driving toward?

   Example (from Commerce):
   > Build TAG's commerce capability into a scalable, technology-led practice. Move from ad-hoc implementation work to a repeatable platform with standardized tooling, pricing models, and delivery patterns.

2. **Strategy** — Current approach. How are you executing on the vision right now? Update this as the initiative evolves.

3. **Team** — Key people involved, with their roles. Format: `[[Person Name]] — Role/context`.

> [!note] The Projects section auto-populates
> The Dataview query in the hub note automatically lists any project whose outlinks reference the initiative. You do not need to manually maintain a project list — just make sure sub-project hub notes link back to the initiative.

## Step 3: Add Sub-Projects

For each workstream under the initiative:

```
/new-project [initiative-folder] "Project Name"
```

Example:

```
/new-project commerce "UX Review"
```

This creates the project under `work/[company]/initiatives/commerce/projects/ux-review/` with its own hub note and `project-instructions.md`.

Each sub-project is a standard project — it gets its own hub note, files folder, and portable instructions file. The only difference is location (under the initiative instead of `work/[company]/projects/`).

## Step 4: Add Stakeholders

Edit the hub note frontmatter to list stakeholders:

```yaml
stakeholders:
  - "[[Person Name]]"
  - "[[Another Person]]"
```

These should be the people you are working with on the initiative at a strategic level, not every contributor across sub-projects.

## Step 5: Log Decisions as They Happen

Use the Key Decisions section in the hub note:

```
**Decided to start with InfoSec pilot** (2026-03-02) — Need a contained domain to prove the SME agent model before scaling. WHY: InfoSec has clear boundaries, existing expertise in-house, and measurable outcomes.
```

Always include the WHY.

---

## Moving an Existing Project to an Initiative

If a standalone project (`work/[company]/projects/[name]`) grows into something bigger with sub-projects:

1. **Move the folder:**
   ```bash
   git mv work/[company]/projects/[name] work/[company]/initiatives/[name]
   ```

2. **Create the sub-structure:**
   ```bash
   mkdir -p work/[company]/initiatives/[name]/projects
   ```

3. **Update the hub note:**
   - Change `type: project` to `type: initiative` in frontmatter
   - Add Vision, Strategy, and Projects sections (with Dataview query)
   - Add Team and Key Decisions sections if missing

4. **Update the entity registry:**
   - Move the entry from the Projects table to the Initiatives table in `_meta/entities.md`
   - Update the path column

5. **Update CLAUDE.md:**
   - Move the entry from Projects to Initiatives in the Entity Registry Reference section
   - Update the Vault Structure section if the old path was listed

6. **Fix any broken references:**
   ```
   /relink [hub-note-path]
   ```

> [!warning] Wikilinks still resolve by filename
> Moving the folder does not break wikilinks since Obsidian resolves by filename, not path. But entity registry paths and CLAUDE.md references need manual updates.
