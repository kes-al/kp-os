Set up this vault for a new user. Interview them, then generate all personalized files.

## Overview

This command runs once to personalize a fresh KP/OS vault. It generates:
- `CLAUDE.md` (the vault operating manual for Claude Code)
- `/_meta/entities.md` (entity registry for wikilinks)
- `/_meta/project-instructions.md` (quick reference)
- `/_meta/vault-backlog.md` (starter backlog)
- Hub notes for clients, projects, and key people
- All necessary directories

Everything else (commands, skills, templates, base files, meta docs, guides, plugins) is already in place.

---

## Step 1: Interview

Ask the following questions conversationally. Don't dump them all at once — ask in natural groups of 2-3 questions, confirm understanding, and move on. Use the answers to populate all generated files.

### Group 1: Identity
- What's your full name?
- What's your job title? (e.g., "Senior Product Manager", "Director of Engineering")
- What company/org do you work at?
- One-sentence description of what you do (e.g., "I manage product strategy for the consumer platform team")

### Group 2: Team
- Who do you report to? (Name and title)
- Do you have direct reports? If so, list them with names and brief roles (e.g., "Sarah Kim — senior engineer", "Mike Chen — TPM")
- Any key stakeholders you work with regularly? (5-10 names with roles/titles — peers, leadership, cross-functional partners)

### Group 3: Work
- What clients or accounts do you manage? (If applicable — skip for non-client-facing roles. Adapt language to their context: "projects", "products", "accounts", "workstreams" as appropriate.)
- What are your current active projects? (Name + one-line description each. For each, note whether it's under a client or an internal initiative.)
- Any key technologies or platforms you work with regularly? (e.g., "AWS, React, Figma, Salesforce, Jira")

### Group 4: Vault Setup
- Check if `.claude/.vault-path` exists (written by setup.sh). If it does, read the vault path from there and confirm with the user. If it doesn't, ask: Where is this vault on your filesystem?
- What is your macOS username? (run `whoami` in the terminal to check)
- Do you use Granola for meeting notes? (determines whether Granola-specific intake processing is relevant)
- Do you plan to use git for vault backup? (y/n)

### Group 5: Preferences
- Any domains (knowledge areas) you want to track beyond work? (e.g., health, finance, cooking, music, fitness, reading, home improvement)
- Any specific aliases or short names people use for your clients/projects? (e.g., "MH" for "Meridian Health", "the platform" for "Consumer Platform Rebuild")
- Do you have regular 1:1 meetings with anyone? (e.g., your manager, direct reports — these people get subfolder structures for meeting notes and agendas)

---

## Step 2: Confirm

Before generating files, show a summary:

```
## KP/OS Bootstrap Summary

**Identity:** [Name], [Title] at [Company]
**Reports to:** [Boss Name] ([Boss Title])
**Direct reports:** [N] ([names])
**Key stakeholders:** [N] listed
**Clients/Accounts:** [N] ([names])
**Active projects:** [N] ([names])
**Technologies:** [list]
**Vault path:** [path]
**Username:** [username]
**Granola:** yes/no
**Git:** yes/no
**Personal domains:** [list]
**1:1 relationships:** [names]

Ready to generate? (y/edit)
```

If "edit", let them correct specific items. If "y", proceed.

---

## Step 3: Generate CLAUDE.md

Write `CLAUDE.md` to the vault root. This is the operating manual Claude Code reads first.

**Key adaptation rules:**
- If they don't manage clients, restructure `/work` around teams/products/workstreams instead of `/work/clients/`
- If they don't use Granola, omit Granola-specific rules and intake paths
- If they're an IC (no direct reports), simplify the `/admin/team` section
- Populate the Entity Registry Reference section with their actual entities
- Use their vault path throughout
- Use their first name where the template says `[NAME-FIRST]`
- Populate the full Vault Structure tree to reflect their actual setup

The CLAUDE.md should include ALL of the following sections. This is the complete specification — don't abbreviate:

### Required CLAUDE.md sections:

1. **Vault Owner** — Their name, title, company, description, reports-to, direct reports, key contacts

2. **Design Philosophy** — All 8 principles (single vault, domains over categories, project nesting, intelligence layer, agent output separation, initiatives vs projects, graph over hierarchy, incremental growth)

3. **Vault Structure** — Full tree reflecting their actual setup, including which client/team folders exist

4. **Dynamic Views (Bases)** — List the 4 .base files with descriptions

5. **File Naming Convention** — Note files (Title Case), system files (lowercase-hyphenated), folders (lowercase-hyphenated)

6. **Critical Rules** — All rules, adapted for their context:
   - Rule 1: Write to `/agent-output` by default
   - Rule 2: Never modify existing notes without instruction
   - Rule 3: Always use frontmatter (include the full YAML example)
   - Rule 4: Always use wikilinks
   - Rule 5: Inline tasks with block IDs — format: `- [ ] ❗ YYYY-MM-DD Task ^t-MMDD-NNN`. Two priority levels: `❗` or nothing.
   - Rule 6: "Today" means the open working day
   - Rule 7: Never reference `/files` directories
   - Rule 8: Always read before writing
   - Rule 9: Projects live under their parent
   - Rule 10: Every project gets a `project-instructions.md` (generated by `/new-project`, synced via `/sync-instructions`)
   - IF GRANOLA: Rule 11 (never use granola_id in frontmatter — use source_id)
   - IF GRANOLA: Rule 12 (move raw Granola files to processed/ after ingesting)
   - Rule 13: Person pages in `/people/` with org subfolders
   - IF 1:1 relationships: Rule 14 (people with recurring 1:1s get a subfolder)

7. **SessionStart Hook** — Describe what it does

8. **Entity Registry Reference** — Full lists of their clients, projects, people, technologies, domains with wikilinks

9. **Skills** — List all 5 skills with descriptions

10. **Slash Commands** — Full categorized list of all 32 commands:
    - Daily: `/startday`, `/closeday`
    - Capture: `/capture`, `/ingest-meeting`, `/ingest-batch`
    - Triage: `/triage`, `/triage-tasks`, `/process`, `/process-batch`
    - Context: `/context`, `/context-load`
    - Thinking: `/ghost`, `/challenge`
    - Discovery: `/trace`, `/connect`, `/drift`, `/emerge`, `/ideas`
    - Review: `/weekly-review`, `/schedule`
    - Scaffolding: `/new-client`, `/new-project`, `/new-initiative`, `/new-domain`, `/new-code`, `/bridge`, `/sync-instructions`
    - Maintenance: `/graduate`, `/relink`, `/audit`, `/commit`

11. **Daily Workflow** — Bookend commands, session start hook description

12. **Daily Note Structure** — Full section list with the callout-based layout:
    ```
    ## Travel            — Active trip context (if traveling)
    > [!abstract] Week N — Status bar: task counts, meeting count. One-liner dashboard.
    > [!warning] Blocked — Only when something is blocked.
    > [!info] Meetings   — Links to processed meeting notes (callout, not h2).
    > [!note]- Plan      — Collapsed callout. Prioritized focus areas.
    ## Tasks             — Real commitments.
      ### Work           — All work tasks, flat list. ❗ first, then sorted by date.
      ### Personal       — Personal tasks. Tag with relevant domains.
    ## Work Log          — What happened during the day.
    ## Suggested Tasks   — Candidates from /ingest-meeting. NOT active until promoted.
    ## Ideas             — Half-formed thoughts tagged #idea for /graduate to find.
    ## End of Day        — Filled by /closeday.
    ```
    Include the task flow explanation: `/ingest-meeting` → Suggested Tasks (holding pen) → user promotes to Tasks. `/capture` writes directly to Tasks because user is deliberately committing. `/startday` only scans Tasks — Suggested Tasks are invisible to it.
    Include the deduplication description (block IDs).
    Include personal tasks explanation if they have personal domains.

13. **How to Handle Requests** — The standard response patterns

14. **Notes on Style** — Concise, scannable, no jargon, include the WHY

---

## Step 4: Generate Entity Registry

Write `/_meta/entities.md` with all entities from the interview.

Structure with tables:
- Clients/Teams/Products (one row per entity with path and aliases)
- Projects — Client/Team-Specific
- Projects — Internal (empty initially — populated via `/new-project`)
- Initiatives (empty initially — populated via `/new-initiative`)
- People (boss, direct reports, stakeholders — with paths and roles)
- Technologies (with aliases)
- Domains (with paths)

Every entity gets a `[[wikilink]]` in the Entity column.

---

## Step 5: Generate Project Instructions

Write `/_meta/project-instructions.md` with:
- Condensed entity quick reference
- Active projects list from interview
- Vault conventions summary

---

## Step 6: Generate Vault Backlog

Write `/_meta/vault-backlog.md` with starter items:
- Configuration tasks (web clipper templates, mobile capture)
- IF GRANOLA: Granola config task
- Future capabilities (person pages, semantic search, voice pipeline)
- Empty process retrospectives section

---

## Step 7: Scaffold Directory Structure

Create all directories based on the interview:

### Work directories
- For each client/team: `/work/clients/[folder-name]/` with `meetings/`, `projects/`, `files/`
- `/work/[company-lowercase]/admin/`
- `/work/[company-lowercase]/admin/team/`
- For each direct report: `/work/[company-lowercase]/admin/team/[firstname-lastname]/`
- `/work/[company-lowercase]/projects/`
- `/work/[company-lowercase]/initiatives/`

### People directories
- `/people/[company-lowercase]/`
- For each 1:1 relationship: `/people/[company-lowercase]/[firstname-lastname]/`
- Any additional org folders needed

### Domain directories
- For each domain from interview: `/domains/[domain-name]/`
- Always include: `/domains/career/`, `/domains/leadership/`, `/domains/pkm/`

### Other directories
- `/notes/` (top-level, for standalone notes)

### Intake directories (confirm they exist)
- `/intake/meetings/manual/`
- `/intake/notes/`
- `/intake/clipper/`
- If Granola: `/intake/meetings/granola/`, `/intake/meetings/granola/processed/`

### Conditional: Install Granola plugin
If user said yes to Granola, copy the Granola plugin from the `_plugins` staging area (if it exists) to `.obsidian/plugins/granola-sync-plus/` and add it to `community-plugins.json`. Update the Granola config's `myName` field with the user's name.

---

## Step 8: Create Hub Notes

For each client/team, create a hub note using the client-hub template at:
`/work/clients/[folder-name]/[Entity Name].md`
Fill in: title, client (folder name), date

For each active project, create:
- Project folder: `/work/clients/[client-folder]/projects/[project-folder]/`
- Subfolders: `meetings/`, `files/`
- Project hub note using project-context template
- `project-instructions.md` using the project-instructions template (fill in project name, path, client, key people)

For key people (boss, direct reports, stakeholders with 1:1s), create person pages using the person template:
- 1:1 people: `/people/[company-lowercase]/[firstname-lastname]/[Full Name].md`
- Others: `/people/[company-lowercase]/[Full Name].md`
Fill in: title, role, org, relationship type

For the company admin hub:
- `/work/[company-lowercase]/admin/Admin.md` (type: index)
- `/work/[company-lowercase]/admin/team/Team.md` (type: note, about org structure)

---

## Step 9: Update Base Files

Check that the `.base` files reference the correct paths:
- If work structure uses a name other than "clients", update `work/clients/clients.base`
- If company folder differs from "tag", update or move `work/tag/projects/projects.base`
- `daily-notes/recent.base` — works as-is
- `intake/inbox.base` — works as-is

If paths changed, rewrite the relevant `.base` files.

---

## Step 10: Verify and Report

Run a quick verification:
- [ ] CLAUDE.md exists at vault root and is complete
- [ ] `/_meta/entities.md` exists with all entities
- [ ] `/_meta/project-instructions.md` exists
- [ ] `/_meta/vault-backlog.md` exists
- [ ] All client/team folders exist with hub notes
- [ ] All project folders exist with hub notes and project-instructions.md
- [ ] Person pages exist for boss and direct reports
- [ ] Domain folders exist
- [ ] Intake structure is correct (including Granola if applicable)
- [ ] `.base` files reference correct paths
- [ ] Granola plugin installed (if applicable)

Output a receipt:

```
╔══════════════════════════════════════════════╗
║  KP/OS — Bootstrap Complete                  ║
╚══════════════════════════════════════════════╝

Vault owner: [Name], [Title] at [Company]
Vault path:  [path]

Generated:
  ✓ CLAUDE.md (vault operating manual)
  ✓ Entity registry with [N] entities
  ✓ [N] client/team folders with hub notes
  ✓ [N] project folders with hub notes + instructions
  ✓ [N] person pages
  ✓ [N] domain folders
  ✓ Vault backlog

Already included:
  ✓ 32 slash commands
  ✓ 5 skill references
  ✓ 12 templates
  ✓ 4 Bases dashboards
  ✓ 5 guides (daily workflow, new project, new client, new initiative, Claude.ai setup)
  ✓ 7 Obsidian plugins (pre-configured)
  ✓ Session start hook
  ✓ Full documentation + GUIDE.md

Next steps:
  1. Read GUIDE.md for how everything works
  2. Run /startday to begin your first day
  3. Use /capture [whatever] to start building the graph

Welcome to KP/OS.
```

---

## Step 11: Clean Up

Remove temporary files:
- Delete `.claude/.vault-path` (was used by setup.sh to pass the path)
- Delete `_plugins/` directory if it still exists in the vault root (staging only)

---

## Rules

- Never skip the confirmation step. Show the full summary before generating.
- Generate CLAUDE.md COMPLETELY — all 14 sections, fully populated. This is the most important file in the vault. Claude Code reads it before every operation.
- Don't generate placeholder content in hub notes. If a section can't be filled from the interview, leave the template comments in place.
- The entity registry must be accurate. Every client, project, person, technology, and domain from the interview gets a row. Aliases are critical for routing.
- Adapt to the user's context. Not everyone manages clients. Not everyone has direct reports. The vault structure should reflect their actual work, not force a template.
