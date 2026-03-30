<p align="center">
  <pre>
  ██╗  ██╗ ██████╗    ██╗     ██████╗ ███████╗
  ██║ ██╔╝ ██╔══██╗  ██╔╝    ██╔═══██╗██╔════╝
  █████╔╝  ██████╔╝ ██╔╝     ██║   ██║███████╗
  ██╔═██╗  ██╔═══╝ ██╔╝      ██║   ██║╚════██║
  ██║  ██╗ ██║    ██╔╝       ╚██████╔╝███████║
  ╚═╝  ╚═╝ ╚═╝    ╚═╝         ╚═════╝ ╚══════╝
  </pre>
</p>

<p align="center">
  <strong>A personal operating system.</strong><br>
  <em>Digital second brain built on an AI-powered knowledge graph.</em><br><br>
  by <a href="https://github.com/kes-al">Kesal Patel</a>
</p>

---

KP/OS is a structured knowledge management system built on [Obsidian](https://obsidian.md) and [Claude Code](https://docs.anthropic.com/en/docs/claude-code). It connects your work, meetings, tasks, and thinking in a single graph with AI as the intelligence layer.

I built this to manage a full client roster, a direct team, cross-functional projects, and my own thinking — all from one system. It's not a template. It's a real workflow that runs a real job, packaged so you can adapt it for yours.

## What you can do with it

- **Prep for any client call in 30 seconds.** Load a client's full context — hub note, recent meetings, open tasks, project status, code docs — with one command.
- **Never lose a meeting action item.** Paste a transcript or let Granola sync it. The system structures the notes, extracts your tasks, files the meeting under the right client and project, and puts your action items in a holding pen for review.
- **Batch-triage 50 accumulated tasks in 5 minutes.** Instead of scrolling through daily notes, review tasks grouped by client and project. Promote, defer, cancel, or delegate in bulk.
- **Answer questions in your own voice.** Ask the vault a question and get a response based on your past decisions, stated positions, and communication patterns. Useful for RFP questions, strategy prompts, and gut-checking your own thinking.
- **Surface themes you haven't consciously noticed.** Discover what concepts keep showing up across unrelated clients and projects — the ideas you're circling without realizing it.
- **Build career evidence automatically.** Every time you close a day, the system scans your work for review-worthy accomplishments and logs them. When review season comes, the evidence is already there.
- **Audit your vault for broken connections.** Find orphaned notes, missing wikilinks, stale projects, and frontmatter issues across hundreds of files. Auto-fix what's safe to fix.
- **Draft real deliverables with full project context.** Hand off deep thinking to Claude.ai — RFP responses, strategy docs, architecture reviews — with persistent context that stays in sync with your vault. No re-explaining your situation every time.

## Two tools, one system

KP/OS runs on two things that work together:

**Claude Code** handles the plumbing. It lives in your terminal, reads your vault, and runs slash commands — creating daily notes, ingesting meetings, managing tasks, scaffolding projects, running audits. It's the operational backbone.

**Claude.ai** handles the thinking. When you need to go deep on a project — write a strategy doc, work through an RFP, analyze architecture options — you open a Claude.ai project that has persistent context from your vault. It knows your clients, your team, your past decisions, your communication style.

The bridge between them is a file called `project-instructions.md` that lives in every project folder. It's a portable, self-contained briefing — no wikilinks, no vault-specific syntax — that you paste into a Claude.ai project's custom instructions. When the project evolves, you re-sync it with one command (`/sync-instructions`) and paste the updated version. Claude.ai always has current context without you manually explaining anything.

This means you can go from "I need to think through the platform migration strategy" to a Claude.ai session that already knows your client, your team, your constraints, and your past decisions — in about 10 seconds.

## The daily habit

Three commands. Every day.

```bash
/startday          # Morning: creates daily note, pulls tasks, builds plan
/capture [text]    # During: routes anything to the right place
/closeday          # Evening: summarizes, carries over, logs career evidence
```

Everything else builds on top of that: meeting ingestion, task triage, context loading, thinking tools, weekly reviews, vault audits. The system includes step-by-step guides for the most common workflows — daily routine, new client onboarding, new project setup, initiative planning, and Claude.ai integration — so you're not just staring at 33 commands.

## Setup

### For technical people

```bash
git clone https://github.com/kes-al/kp-os.git ~/Documents/vault
cd ~/Documents/vault
claude
# then type: /bootstrap
```

### For everyone else

1. Download the [latest release](https://github.com/kes-al/kp-os/releases/latest) as a zip
2. Extract it somewhere
3. Open Terminal, type `bash `, drag `setup.sh` into the window, press Enter
4. Follow the prompts — takes about 5 minutes

The installer handles Homebrew, Claude Code, Obsidian, plugins, and configuration. Then `/bootstrap` interviews you about your role, team, and work to personalize everything.

## What's in the box

- **33 slash commands** — daily workflow, meeting ingestion, task management, triage, discovery, scaffolding, maintenance
- **5 AI skill files** — Obsidian markdown, CLI, Bases, web extraction, canvas references that Claude Code consults before writing vault content
- **12 templates** — daily notes, clients, projects, people, meetings, domains, decisions, RFPs, initiatives
- **5 guides** — step-by-step walkthroughs for daily workflow, new clients, new projects, initiatives, Claude.ai setup
- **4 live dashboards** — clients, projects, daily notes, intake inbox (Obsidian Bases)
- **8 plugins** — pre-configured and ready to go
- **Session start hook** — auto-loads your daily context when Claude Code opens
- **Interactive installer** — one script sets up everything
- **Bootstrap interview** — personalizes the system for your role, team, and work

<details>
<summary><strong>Full command reference</strong></summary>

### Daily workflow
| Command | What it does |
|---------|-------------|
| `/startday` | Creates daily note, pulls open tasks, generates prioritized plan |
| `/closeday` | Summarizes accomplishments, carries over tasks, captures career evidence |
| `/capture [text]` | Routes natural language to the right section — tasks, ideas, observations |

### Meetings
| Command | What it does |
|---------|-------------|
| `/ingest-meeting` | Structures a transcript, extracts action items, routes to client/project |
| `/ingest-batch` | Process multiple meetings in sequence |

### Triage
| Command | What it does |
|---------|-------------|
| `/triage` | Sweep all of /intake — meetings, notes, web clips |
| `/triage-tasks` | Batch review accumulated tasks by workstream |
| `/process [note]` | Make any note vault-native (wikilinks, frontmatter, formatting) |

### Context
| Command | What it does |
|---------|-------------|
| `/context` | Full vault briefing — everything that's active |
| `/context-load [target]` | Deep-dive on one client, project, or topic |

### Thinking & discovery
| Command | What it does |
|---------|-------------|
| `/ghost [question]` | Answer a question in your voice, based on vault history |
| `/challenge [topic]` | Stress-test your thinking — find contradictions and blind spots |
| `/trace [topic]` | Timeline of how an idea evolved across the vault |
| `/connect [A] and [B]` | Find hidden links between two topics |
| `/drift` | Surface recurring themes you haven't consciously noticed |
| `/emerge` | Find clusters of ideas forming into something bigger |
| `/ideas` | Full idea generation pass — problems, tools, essays, connections |

### Scaffolding
| Command | What it does |
|---------|-------------|
| `/new-client [name]` | Scaffold client folder with hub note |
| `/new-project [parent] [name]` | Scaffold project under a client or initiative |
| `/new-initiative [name]` | Scaffold a strategic initiative with sub-projects |
| `/new-domain [name]` | Scaffold a knowledge domain |
| `/new-code [path] [repo] [url]` | Register a codebase |
| `/bridge [code-path]` | Connect code docs to the vault graph |
| `/sync-instructions [project]` | Re-derive portable project instructions from hub note |

### Maintenance
| Command | What it does |
|---------|-------------|
| `/graduate` | Promote ideas from daily notes to permanent notes |
| `/relink [file]` | Add missing wikilinks to a note |
| `/audit` | Vault health scan (7 dimensions, auto-fix mode) |
| `/weekly-review` | Week in review + drift check + next week priorities |
| `/commit` | Git commit and push |

</details>

## Vault structure

```
/vault
  /work                    ← Clients/teams and internal projects
    /clients/[name]/       ← Hub note + meetings + projects
    /[company]/            ← Internal: admin, team, projects, initiatives
  /people/                 ← Person pages by organization
  /domains/                ← Knowledge areas (professional + personal)
  /daily-notes/            ← Daily journal — the core working surface
  /intake/                 ← Unprocessed items (meetings, notes, clips)
  /agent-output/           ← Where Claude writes — you review and graduate
  /templates/              ← Note templates
  /_meta/                  ← System docs, entity registry, guides
  /code/                   ← Symlinks to code project docs
  /.claude/                ← Commands, skills, hooks
```

## This is a starting point

This system reflects how I work. The folder structure, the commands, the daily note format — all of it is structured and personal. You should change it.

- Restructure folders to match your thinking
- Modify commands by editing the markdown files in `/.claude/commands/`
- Add new commands for your workflows
- Change templates to match your note-taking style

You can do all of this in Claude Code itself. Just tell it what you want to change. The entire system is plain markdown files — nothing is locked down.

## Attribution

The starting point for KP/OS was **Vin Verma**'s work ([@internetvin](https://x.com/internetvin) · [internetvin.com](https://internetvin.com)) on using an Obsidian vault as a knowledge graph for Claude Code. The discovery commands — `/ghost`, `/challenge`, `/emerge`, `/drift`, `/ideas`, `/trace`, `/connect`, `/graduate` — come from his framework. Watch the original walkthrough: [How I Use Obsidian + Claude Code to Run My Life](https://www.youtube.com/watch?v=6MBq1paspVU) (The Startup Ideas Podcast with Greg Isenberg).

Everything else — the client-project architecture, meeting ingestion pipeline, task management with deduplication, triage system, scaffolding commands, Claude.ai integration layer, entity registry routing, career evidence capture, vault auditing, the bootstrap interview, and the daily note workflow — I built to run my own job and packaged here for others.

## Requirements

- macOS (the installer uses Homebrew)
- [Obsidian](https://obsidian.md) (installed by setup.sh)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (installed by setup.sh)
- An Anthropic API key ([console.anthropic.com](https://console.anthropic.com))

## License

MIT
