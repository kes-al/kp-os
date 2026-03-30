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
  by <a href="https://github.com/kesapat">Kesal Patel</a>
</p>

---

KP/OS is an opinionated knowledge management system built on [Obsidian](https://obsidian.md) and [Claude Code](https://docs.anthropic.com/en/docs/claude-code). It connects your work, meetings, tasks, and thinking in a single graph with AI as the intelligence layer.

This is the system I use every day to manage 30+ clients, direct reports, cross-functional projects, and my own thinking. It's not a generic template — it's a real workflow that runs a real job, packaged so you can adapt it for yours.

## What's in the box

- **33 slash commands** — daily workflow, meeting ingestion, task management, triage, discovery, scaffolding, maintenance
- **5 AI skill files** — Obsidian markdown, CLI, Bases, web extraction, canvas
- **12 templates** — daily notes, clients, projects, people, meetings, domains, decisions, RFPs, initiatives
- **5 guides** — step-by-step walkthroughs for daily workflow, new clients, new projects, initiatives, Claude.ai setup
- **4 live dashboards** — clients, projects, daily notes, intake inbox (Obsidian Bases)
- **8 plugins** — pre-configured and ready to go
- **Session start hook** — auto-loads your daily context when Claude Code opens
- **Interactive installer** — one script sets up everything
- **Bootstrap interview** — personalizes the system for your role, team, and work

## How it works

Three commands. Every day.

```bash
/startday          # Morning: creates daily note, pulls tasks, builds plan
/capture [text]    # During: routes anything to the right place
/closeday          # Evening: summarizes, carries over, logs career evidence
```

Everything else builds on top of that: meeting ingestion, task triage, context loading, thinking tools, weekly reviews, vault audits.

## Setup

### For technical people

```bash
git clone https://github.com/kesapat/kpos.git ~/Documents/vault
cd ~/Documents/vault
claude
# then type: /bootstrap
```

### For everyone else

1. Download the [latest release](https://github.com/kesapat/kpos/releases/latest) as a zip
2. Extract it somewhere
3. Open Terminal, type `bash `, drag `setup.sh` into the window, press Enter
4. Follow the prompts — takes about 5 minutes

The installer handles Homebrew, Claude Code, Obsidian, plugins, and configuration. Then `/bootstrap` interviews you about your role, team, and work to personalize everything.

## Commands

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

This system reflects how I work. The folder structure, the commands, the daily note format — all of it is opinionated and personal. You should change it.

- Restructure folders to match your thinking
- Modify commands by editing the markdown files in `/.claude/commands/`
- Add new commands for your workflows
- Change templates to match your note-taking style

You can do all of this in Claude Code itself. Just tell it what you want to change. The entire system is plain markdown files — nothing is locked down.

## Attribution

KP/OS is built on a framework by **Vin Verma** ([@internetvin](https://x.com/internetvin) · [internetvin.com](https://internetvin.com)), who created the concept of using an Obsidian vault as a knowledge graph for Claude Code. The discovery commands — `/ghost`, `/challenge`, `/emerge`, `/drift`, `/ideas`, `/trace`, `/connect`, `/graduate` — come from his work.

Watch the original walkthrough: [How I Use Obsidian + Claude Code to Run My Life](https://www.youtube.com/watch?v=6MBq1paspVU) (The Startup Ideas Podcast with Greg Isenberg)

## Requirements

- macOS (the installer uses Homebrew)
- [Obsidian](https://obsidian.md) (installed by setup.sh)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (installed by setup.sh)
- An Anthropic API key ([console.anthropic.com](https://console.anthropic.com))

## License

MIT
