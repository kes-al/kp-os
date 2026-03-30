# KP/OS — How to Use This System

## What is this?

KP/OS is an AI-powered knowledge management system. It runs on two things: **Obsidian** (where your notes, meetings, tasks, and thinking live) and **Claude Code** (an AI agent that helps you manage all of it through natural language commands).

Everything in your vault is connected through a knowledge graph — clients link to projects, projects link to people, people link to meetings, meetings generate tasks. The more you use it, the smarter the connections get.

---

## This is a starting point, not a rulebook

This system was built by the vault owner for how he personally manages his work as a technology leader with 30+ clients. The folder structure, the command workflows, the daily note format — it all reflects his workflow.

**You don't have to use it this way.** This is one opinionated setup. You can:

- Restructure folders to match how you think
- Modify any command by editing the markdown files in `/.claude/commands/`
- Add new commands for workflows that matter to you
- Change the daily note template
- Add or remove sections from hub notes

The best part: you can do all of this *in Claude Code itself*. Just tell it what you want to change and it'll help you rebuild the commands and structure. The system is made of plain markdown files — there's nothing locked down.

---

## Attribution

KP/OS is built on a framework created by **Vin Verma** ([@internetvin](https://x.com/internetvin) · [internetvin.com](https://internetvin.com)), who pioneered the concept of using an Obsidian vault as a knowledge graph for Claude Code. The discovery commands — `/ghost`, `/challenge`, `/emerge`, `/drift`, `/ideas`, `/trace`, `/connect`, `/graduate` — come from his work. The professional workflow layer — client management, meeting ingestion, task tracking, triage, scaffolding, and the architecture that ties it together — was built on top of that foundation.

To understand the original thinking behind this approach, watch Vin's episode on The Startup Ideas Podcast with Greg Isenberg: [youtube.com/watch?v=6MBq1paspVU](https://www.youtube.com/watch?v=6MBq1paspVU)

---

## The daily habit

This is the minimum. If you do nothing else, do this.

### Morning (2 minutes)

Open the Terminal panel in Obsidian and type:

```
claude
```

Then:

```
/startday
```

This creates your daily note, pulls in any open tasks from previous days, and builds a prioritized plan for the day (must-do, should-do, could-do). The daily note opens with a status bar showing your task counts and meetings at a glance. Read the plan. That's your roadmap.

### During the day

Whenever something happens — a thought, a task, something from a meeting — capture it:

```
/capture Follow up with the design team on the homepage wireframes
```

That's it. Claude figures out whether it's a task, an idea, or an observation, wikilinks the right entities, and puts it in the right section of your daily note.

### End of day (2 minutes)

```
/closeday
```

This summarizes what got done, carries over unfinished tasks (so nothing falls through the cracks), and surfaces any connections between the day's work. It also scans for career-worthy accomplishments and logs them automatically.

---

## Common scenarios

**"I just got out of a meeting."**
Copy the transcript (or if you use Granola, it syncs automatically) and run:
```
/ingest-meeting [paste transcript or path to file]
```
Claude structures the notes, extracts action items, files the note under the right client/project, and adds your tasks to today's daily note as suggestions.

**"I have a bunch of unprocessed meetings."**
```
/ingest-batch
```
Steps through each one with full processing. You can skip or stop at any point.

**"I need to prep for a client call."**
```
/context-load [client name]
```
Loads everything about that client — hub note, recent meetings, open tasks, active projects, code docs. Full briefing in seconds.

**"I have a pile of suggested tasks I haven't reviewed."**
```
/triage-tasks
```
Groups them by workstream and lets you batch-decide: promote, done, cancel, delegate, reschedule, or defer. Way faster than going through them one by one.

**"My intake folder has stuff piling up."**
```
/triage
```
Sweeps all of `/intake` — meetings, notes, web clips. Processes everything with the right pipeline.

**"I want to think through a problem."**
```
/ghost How should we approach the platform migration?
```
Claude answers the way you would, based on your vault history — your past decisions, stated positions, and communication style.

**"I want pushback on my thinking."**
```
/challenge [topic]
```
Stress-tests your position. Finds contradictions in your vault, identifies assumptions, generates counter-arguments.

**"New client starting."**
```
/new-client [name]
```
Scaffolds the entire folder structure: hub note, meetings, projects, files.

**"New project under an existing client."**
```
/new-project [client] [project name]
```

**"Starting a new strategic initiative with sub-projects."**
```
/new-initiative [name]
```

**"What did I do this week?"**
```
/weekly-review
```
Accomplishments, patterns, a drift check (am I spending time on what I said matters?), and next week priorities.

**"What ideas are forming that I haven't noticed?"**
```
/emerge
```
Scans the vault for clusters of related ideas coalescing into something bigger than individual notes.

---

## Key concepts

### Wikilinks `[[like this]]`
The double-bracket links are how notes connect to each other. When you see `[[Project Alpha]]` in a note, that's a link to the Project Alpha note. Click it to navigate there. These connections are what make the knowledge graph work — they let Claude (and you) trace relationships across your vault.

### Frontmatter
The stuff at the top of every note between `---` marks:
```yaml
---
title: Note Title
type: meeting
client: acme-corp
status: active
date: 2026-03-30
---
```
This is metadata that commands and dashboards use to organize and query your notes. You don't need to write it by hand — the commands generate it automatically.

### Block IDs `^t-0330-001`
Tasks carry these identifiers at the end of the line. They're how the system tracks a task across multiple daily notes. When a task carries forward from Monday to Tuesday to Wednesday, the block ID stays the same, and `/startday` deduplicates so it only appears once.

### Tasks vs. Suggested Tasks
- **Tasks** (under `## Tasks` > `### Work`) — things you've committed to doing. `/capture` writes here. `/startday` pulls these forward. Flat list sorted by priority (❗ first) then date.
- **Suggested Tasks** — candidates extracted from meetings by `/ingest-meeting`. These are holding-pen items. You review and promote them to Tasks (or discard them) during `/closeday` or `/triage-tasks`.

### Daily note structure
Each daily note has a consistent layout:
- **Status bar** (`> [!abstract]`) — week number, task counts, meeting count. One-line dashboard.
- **Meetings** (`> [!info]`) — links to processed meeting notes.
- **Plan** (`> [!note]-`) — collapsed callout with must-do, should-do, could-do. Populated by `/startday`.
- **Tasks** — `### Work` (flat list, ❗ priority first) and `### Personal`.
- **Work Log** — what happened during the day.
- **Suggested Tasks** — holding pen from meeting ingestion.
- **Ideas** — tagged `#idea` for `/graduate` to find.
- **End of Day** — filled by `/closeday`.

### Agent output
When Claude generates content (meeting notes, analyses, ideas), it writes to `/agent-output/` by default. This is a staging area. You review the output, and if it's good, you "graduate" it to its permanent home with `/graduate` or by manually moving it.

### The entity registry `/_meta/entities.md`
A master list of every client, project, person, technology, and domain in your vault, with aliases. This is how commands know that "MH" means `[[Meridian Health]]` and "the RFP" means `[[Acme RFP]]`. When you add a new client or project, it gets registered here so all commands can recognize it.

---

## Command cheat sheet

### Daily workflow
| Command | What it does |
|---------|-------------|
| `/startday` | Creates daily note, pulls tasks, builds plan |
| `/closeday` | Summarizes day, carries over tasks, logs career evidence |
| `/capture [text]` | Routes natural language to the right place |

### Meetings
| Command | What it does |
|---------|-------------|
| `/ingest-meeting [transcript]` | Structures a meeting, extracts tasks |
| `/ingest-batch` | Process multiple meetings in sequence |

### Triage
| Command | What it does |
|---------|-------------|
| `/triage` | Sweep all of /intake — meetings, notes, clips |
| `/triage-tasks` | Batch review suggested and overdue tasks |
| `/process [note]` | Make a single note vault-native |
| `/process-batch` | Process multiple raw notes |

### Context
| Command | What it does |
|---------|-------------|
| `/context` | Full vault briefing — everything active |
| `/context-load [target]` | Deep-dive context for one client/project |

### Thinking
| Command | What it does |
|---------|-------------|
| `/ghost [question]` | Answer a question in your voice |
| `/challenge [topic]` | Stress-test your thinking |

### Discovery
| Command | What it does |
|---------|-------------|
| `/trace [topic]` | Timeline of how an idea evolved |
| `/connect [A] and [B]` | Find hidden links between two topics |
| `/drift` | Surface recurring themes you haven't noticed |
| `/emerge` | Find clusters of ideas forming into something bigger |
| `/ideas` | Full idea generation pass |

### Review
| Command | What it does |
|---------|-------------|
| `/weekly-review` | Week in review + next week priorities |
| `/schedule` | Suggested schedule for the week |

### Scaffolding
| Command | What it does |
|---------|-------------|
| `/new-client [name]` | Create client folder structure |
| `/new-project [parent] [name]` | Create project under a client or initiative |
| `/new-initiative [name]` | Create strategic initiative with sub-projects |
| `/new-domain [name]` | Create knowledge domain |
| `/new-code [path] [repo] [url]` | Register a codebase |
| `/bridge [code-path]` | Connect code docs to the vault graph |
| `/sync-instructions [project]` | Re-derive project instructions from hub note |

### Maintenance
| Command | What it does |
|---------|-------------|
| `/graduate` | Promote ideas from daily notes to permanent notes |
| `/relink [file]` | Add missing wikilinks to a note |
| `/audit` | Vault health scan (7 dimensions) |
| `/audit fix` | Auto-fix issues found by audit |
| `/commit` | Git commit and push |

---

## Where your stuff lives

```
/vault
  /work                    ← All client and internal work
    /clients/[name]/       ← One folder per client
      [Client].md          ← Client hub note (overview, contacts, tech)
      /meetings/           ← Client-level meeting notes
      /projects/[name]/    ← Projects under this client
    /[company]/            ← Your company's internal work
      /admin/team/         ← Team management, 1:1 folders
      /projects/           ← Internal projects
      /initiatives/        ← Strategic themes with sub-projects
  /people/                 ← Person pages by organization
  /domains/                ← Knowledge areas (AI, finance, career, etc.)
  /daily-notes/            ← Daily journal — the core working surface
  /intake/                 ← Unprocessed items (meetings, notes, clips)
  /agent-output/           ← Where Claude writes — you review and graduate
  /templates/              ← Note templates
  /attachments/            ← Pasted images and media
  /_meta/                  ← System docs, entity registry, guides
  /code/                   ← Symlinks to code project docs
  /.claude/                ← Commands, skills, hooks
```

---

## Tips

- **Let `/startday` finish before adding tasks.** It deduplicates and organizes. If you add tasks manually first, they might get duplicated.
- **Don't edit files in `/agent-output/` permanently.** That folder is a staging area. Use `/graduate` to promote good content, or manually move files to their permanent home.
- **Use `/capture` for everything.** Don't overthink where something goes. Capture it, and the system routes it. You can always reorganize later.
- **Run `/triage` or `/triage-tasks` weekly.** Letting suggested tasks pile up defeats the purpose. A quick weekly triage keeps things clean.
- **Run `/audit` monthly.** It finds orphaned notes, stale projects, missing wikilinks, and other hygiene issues. Follow up with `/audit fix` for safe auto-repairs.
- **The more you write, the smarter it gets.** Commands like `/ghost`, `/drift`, `/emerge`, and `/ideas` work better with more history. Daily notes are fuel.
- **If something feels wrong, just ask Claude.** You can say "this command isn't working the way I want" or "I want to change how tasks work" and Claude will help you modify the system. It's all just markdown.

---

## Getting more help

- **Full command reference:** `/_meta/slash-commands.md`
- **Workflow guide (when to use what):** `/_meta/vault-workflow-guide.md`
- **Guides:** `/_meta/guides/` — step-by-step walkthroughs for daily workflow, new clients, new projects, initiatives, Claude.ai setup
- **Plugin list:** `/_meta/recommended-plugins.md`
- **Quick start (settings, first day):** `/_meta/quick-start.md`

Or just ask Claude: "What command should I use for [whatever you're trying to do]?"

---

*KP/OS v1.0 — A personal operating system. Digital second brain built on an AI-powered knowledge graph.*
