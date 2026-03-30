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

<p align="left">
  <strong>A personal operating system.</strong><br>
  <em>Digital second brain built on an AI-powered knowledge graph.</em><br><br>
  by <a href="https://github.com/kes-al">Kesal Patel</a>
</p>

---

KP/OS is a structured knowledge management system that puts all of your work — meetings, tasks, projects, people, ideas, and decisions — into one connected workspace, with AI that helps you manage it.

It's built on [Obsidian](https://obsidian.md), a free note-taking app where your notes are just markdown files on your computer, and [Claude Code](https://docs.anthropic.com/en/docs/claude-code), an AI agent that runs in your terminal and can read, write, and organize those files for you.

I built this to manage a full client roster, a direct team, cross-functional projects, and my own thinking — all from one system. It's not a template. It's a real workflow that runs a real job, packaged so you can adapt it for yours.

## The problem this solves

Meeting notes in one app. Tasks in another. Project context in your head. You come out of four back-to-back meetings and you've already forgotten what was decided in the first one. Action items live in Slack messages you'll never scroll back to. When someone asks "where did we land on that?" you're digging through three tools and still guessing.

KP/OS puts everything in one place and uses AI to keep it organized. Your meetings generate structured notes that file themselves. Action items get extracted and tracked. When you need to prep for a call, one command loads everything you need. When review season comes, your accomplishments are already logged. Nothing falls through the cracks because the system is doing the bookkeeping for you.

## How it works

You work in a folder of markdown files (Obsidian calls this a "vault"). Notes link to each other — a meeting note links to a client, the client links to a project, the project links to people. Over time, these connections form a knowledge graph that reflects how your work actually fits together.

Claude Code is the AI that operates on this graph. You give it commands by typing things like `/startday` or `/capture Follow up with the design team on wireframes` into the terminal. Each command is a plain-English markdown file that tells the AI what to do — read these files, create that note, extract tasks, file things in the right place. You can read every command, modify them, or write new ones.

The system runs on three daily commands:

```bash
/startday          # Morning: creates your daily note, pulls in open tasks, builds a prioritized plan
/capture [text]    # Anytime: say what happened and it routes to the right place — task, idea, or log entry
/closeday          # Evening: summarizes what got done, carries over unfinished work, logs career evidence
```

Everything else builds on top of that foundation.

## What you can do with it

Here are a few things the system handles. There are 33 commands total — this is just a taste.

- **Prep for any client call in 30 seconds.** Load a client's full context — recent meetings, open tasks, project status, key contacts — with one command.
- **Never lose a meeting action item.** Paste a transcript (or let [Granola](https://granola.ai) sync it automatically). The system structures the notes, extracts your tasks, files the meeting under the right client and project, and puts action items in a holding pen for review.
- **Batch-triage 50 accumulated tasks in 5 minutes.** Instead of scrolling through daily notes, review tasks grouped by client and project. Promote, defer, cancel, or delegate in bulk.
- **Ask the vault a question and get an answer in your own voice.** Based on your past decisions, stated positions, and communication patterns. Useful for RFP questions, strategy prompts, and gut-checking your own thinking.
- **Surface themes you haven't consciously noticed.** Discover what concepts keep showing up across unrelated clients and projects — the ideas you're circling without realizing it.
- **Build career evidence automatically.** Every time you close a day, the system scans your work for review-worthy accomplishments and logs them. When review season comes, the evidence is already there.
- **Audit your vault for broken connections.** Find orphaned notes, missing links, stale projects, and issues across hundreds of files. Auto-fix what's safe to fix.
- **Draft real deliverables with full project context.** Hand off deep thinking to [Claude.ai](https://claude.ai) — RFP responses, strategy docs, architecture reviews — with persistent context that stays in sync with your vault. No re-explaining your situation every time.

## Two tools, one system

KP/OS uses two AI tools that complement each other:

**Claude Code** is the operational backbone. It runs in a terminal inside Obsidian, reads your files, and executes commands. Think of it as an assistant that knows your entire vault and can do things like "process this meeting transcript and file it under the right client" or "show me everything that's overdue."

**[Claude.ai](https://claude.ai)** is for deep thinking. When you need to write a strategy doc, work through an RFP, or analyze architecture options, you open a Claude.ai project that has persistent context from your vault — it knows your clients, your team, your past decisions. You're not starting from scratch every conversation.

The bridge between them is a file called `project-instructions.md` that lives in every project folder. It's a self-contained briefing that you paste into a Claude.ai project's custom instructions. When the project evolves, you re-sync it with one command and paste the updated version. Claude.ai always has current context without you manually explaining anything.

## Guides

The system ships with step-by-step guides so you're not figuring things out from raw command files:

| Guide | What it covers |
|-------|---------------|
| **[Daily Workflow](_meta/guides/daily-workflow.md)** | The full morning-to-night routine — what to run, when, and why |
| **[New Client Onboarding](_meta/guides/new-client-onboarding.md)** | Adding a new client — folder setup, first meeting, contacts, entity registration |
| **[New Project Setup](_meta/guides/new-project-setup.md)** | Setting up a project end-to-end — from folder creation to Claude.ai integration |
| **[New Initiative Setup](_meta/guides/new-initiative-setup.md)** | When something is bigger than a project — how to create strategic initiatives with sub-projects |
| **[Claude.ai Project Setup](_meta/guides/claude-ai-project-setup.md)** | Connecting your vault to Claude.ai for deep work sessions with persistent context |

There's also a full user manual (`GUIDE.md`) in the vault root that covers concepts, common scenarios, and tips.

## Setup

### If you're comfortable with a terminal

```bash
git clone https://github.com/kes-al/kp-os.git ~/Documents/vault
cd ~/Documents/vault
claude
# then type: /bootstrap
```

### If you're not

1. Download the [latest release](https://github.com/kes-al/kp-os/releases/latest) as a zip
2. Extract it somewhere
3. Open Terminal (Cmd+Space, type "Terminal", press Enter)
4. Type `bash `, drag `setup.sh` into the window, press Enter
5. Follow the prompts — takes about 5 minutes

The installer handles everything: Homebrew (a Mac package manager), Claude Code, Obsidian, plugins, and configuration. After that, `/bootstrap` runs an interview — it asks about your role, team, clients, and projects, then generates a personalized vault with the right folder structure, entity registry, and configuration files.

Once bootstrap finishes, run `/startday` and you're working.

## What's in the box

- **33 slash commands** — daily workflow, meeting ingestion, task management, triage, discovery, scaffolding, maintenance
- **5 AI skill files** — references that Claude Code reads before writing vault content (Obsidian syntax, CLI patterns, dashboard creation)
- **12 templates** — daily notes, clients, projects, people, meetings, domains, decisions, RFPs, initiatives
- **5 guides** — step-by-step walkthroughs (see above)
- **4 live dashboards** — queryable views for clients, projects, daily notes, and the intake inbox
- **8 Obsidian plugins** — pre-configured and ready to go
- **Session start hook** — automatically loads your daily context when Claude Code opens
- **Interactive installer** — one script sets up everything
- **Bootstrap interview** — personalizes the vault for your specific role and work

<details>
<summary><strong>Full command reference (33 commands)</strong></summary>

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
| `/process [note]` | Make any note vault-native (links, metadata, formatting) |

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
| `/new-client [name]` | Set up a new client with folder structure and hub note |
| `/new-project [parent] [name]` | Set up a project under a client or initiative |
| `/new-initiative [name]` | Set up a strategic initiative with sub-projects |
| `/new-domain [name]` | Set up a knowledge domain |
| `/new-code [path] [repo] [url]` | Register a codebase |
| `/bridge [code-path]` | Connect code docs to the vault graph |
| `/sync-instructions [project]` | Re-derive portable project instructions from hub note |

### Maintenance
| Command | What it does |
|---------|-------------|
| `/graduate` | Promote ideas from daily notes to permanent notes |
| `/relink [file]` | Add missing links to a note |
| `/audit` | Vault health scan (7 dimensions, auto-fix mode) |
| `/weekly-review` | Week in review + drift check + next week priorities |
| `/commit` | Git commit and push |

</details>

## Vault structure

Everything lives in one folder. Here's how it's organized:

```
/vault
  /work                    ← Clients/teams and internal projects
    /clients/[name]/       ← One folder per client: hub note + meetings + projects
    /[company]/            ← Your company's internal work: admin, team, projects, initiatives
  /people/                 ← Person pages organized by company/context
  /domains/                ← Knowledge areas — professional and personal
  /daily-notes/            ← One note per day — the core working surface
  /intake/                 ← Unprocessed items waiting to be filed (meetings, notes, web clips)
  /agent-output/           ← Where the AI writes — you review and promote to permanent locations
  /templates/              ← Note templates for every type
  /_meta/                  ← System docs, entity registry, guides
  /code/                   ← Links to active code project documentation
  /.claude/                ← AI commands, skill references, hooks
```

## This is a starting point

This system reflects how I work. The folder structure, the commands, the daily note format — all of it is structured and personal. You should change it.

- Restructure folders to match your thinking
- Modify commands by editing the markdown files in `/.claude/commands/`
- Add new commands for your workflows
- Change templates to match your note-taking style

You can do all of this in Claude Code itself. Just tell it what you want to change — "I want the daily note to have a different layout" or "I want a command that does X" — and it'll help you build it. The entire system is plain markdown files. Nothing is locked down.

## Attribution

The starting point for KP/OS was **Vin Verma**'s work ([@internetvin](https://x.com/internetvin) · [internetvin.com](https://internetvin.com)) on using an Obsidian vault as a knowledge graph for Claude Code. The discovery commands — `/ghost`, `/challenge`, `/emerge`, `/drift`, `/ideas`, `/trace`, `/connect`, `/graduate` — come from his framework. Watch the original walkthrough: [How I Use Obsidian + Claude Code to Run My Life](https://www.youtube.com/watch?v=6MBq1paspVU) (The Startup Ideas Podcast with Greg Isenberg).

Everything else — the client-project architecture, meeting ingestion pipeline, task management with deduplication, triage system, scaffolding commands, Claude.ai integration layer, entity registry routing, career evidence capture, vault auditing, the bootstrap interview, and the daily note workflow — I built to run my own job and packaged here for others.

## Requirements

- macOS (the installer uses Homebrew)
- [Obsidian](https://obsidian.md) (installed by setup.sh)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (installed by setup.sh)
- An Anthropic API key or Claude subscription ([console.anthropic.com](https://console.anthropic.com))

## License

MIT
