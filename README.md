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

KP/OS is a structured knowledge management system built on [Obsidian](https://obsidian.md) and [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Your work, meetings, tasks, projects, people, and ideas all live in one connected graph, and AI handles the organization and heavy lifting.

I built this to manage a full client roster, a team, cross-functional projects, and my own thinking, all from one system. It's not a template. It's a working system that runs a real job, packaged so you can adapt it for yours.

## Why I built this

Meeting notes end up in one app. Tasks in another. Project context lives in your head until someone asks a question and you're digging through three tools trying to remember what was decided. Action items from meetings disappear into threads you'll never scroll back to.

I wanted everything in one place with an AI that could actually help me manage it. Meetings generate structured notes that file themselves under the right client and project. Action items get extracted and tracked. When I need to prep for a call, one command loads everything I need. When review season comes, my accomplishments are already logged. The system does the bookkeeping so I can focus on the work.

## How it works

You work in a folder of markdown files (Obsidian calls this a "vault"). Notes link to each other: a meeting note links to a client, the client links to a project, the project links to people. Over time, these connections form a knowledge graph that mirrors how your work actually fits together.

Claude Code operates on this graph. You give it commands by typing things like `/startday` or `/capture Follow up with the design team on wireframes` into the terminal. Each command is just a markdown file that tells the AI what to do: read these files, create that note, extract tasks, file things in the right place. You can open any command file, read it, change it, or write new ones from scratch.

Three commands run the day:

```bash
/startday          # Creates your daily note, pulls in open tasks, builds a prioritized plan
/capture [text]    # Say what happened and it routes to the right place (task, idea, or log entry)
/closeday          # Summarizes what got done, carries over unfinished work, logs career evidence
```

Everything else builds on top of that: meeting ingestion, task triage, context loading, thinking tools, weekly reviews, vault audits. There are 33 commands total.

## A few things it can do

- **Prep for a client call in 30 seconds.** One command loads a client's full context: recent meetings, open tasks, project status, key contacts.
- **Process meeting transcripts.** Paste a transcript or let [Granola](https://granola.ai) sync it. The system structures the notes, extracts your action items, and files everything under the right client and project.
- **Batch-triage tasks.** Review 50 accumulated tasks grouped by client and project in about 5 minutes. Promote, defer, cancel, or delegate in bulk.
- **Answer questions in your own voice.** Ask the vault something and get a response based on your past decisions and stated positions. Good for RFP questions and strategy prompts.
- **Find patterns you missed.** Surface themes that keep showing up across unrelated clients and projects without you noticing.
- **Build career evidence automatically.** Every time you close a day, the system scans for review-worthy accomplishments and logs them.
- **Audit your vault.** Find orphaned notes, missing links, stale projects, and metadata issues across hundreds of files. Auto-fix what's safe to fix.
- **Work on real deliverables with full context.** Hand off deep work to [Claude.ai](https://claude.ai) for RFP responses, strategy docs, or architecture reviews. The AI has persistent context from your vault so you're not re-explaining everything each session.

## How I use Claude Code and Claude.ai together

This is how I work with the system, but it's not the only way. You could use just Claude Code and get most of the value. You could use just Claude.ai with the vault as a reference. The system is flexible.

That said, the two tools complement each other well:

**Claude Code** runs in the terminal and handles operations: creating notes, ingesting meetings, managing tasks, scaffolding projects, running audits. It reads and writes your vault files directly.

**[Claude.ai](https://claude.ai)** is for deeper work. When I need to write a strategy doc, work through an RFP, or analyze architecture options, I open a Claude.ai project that already has context from my vault. It knows my clients, my team, my past decisions. I use it to draft deliverables, think through problems, and craft responses without re-explaining the full situation every time.

The connection between them is a file called `project-instructions.md` that lives in every project folder. It's a self-contained briefing that you paste into a Claude.ai project's custom instructions. When things change, you re-sync with one command and paste the update. Claude.ai stays current without you explaining anything manually.

## Guides

The system includes step-by-step guides so you're not figuring things out from raw command files:

| Guide | What it covers |
|-------|---------------|
| **[Daily Workflow](_meta/guides/daily-workflow.md)** | The full morning-to-night routine: what to run, when, and why |
| **[New Client Onboarding](_meta/guides/new-client-onboarding.md)** | Adding a new client: folder setup, first meeting, contacts |
| **[New Project Setup](_meta/guides/new-project-setup.md)** | Setting up a project end-to-end, including Claude.ai integration |
| **[New Initiative Setup](_meta/guides/new-initiative-setup.md)** | When something is bigger than a project and needs sub-projects |
| **[Claude.ai Project Setup](_meta/guides/claude-ai-project-setup.md)** | Connecting a vault project to Claude.ai for deep work sessions |

There's also a full user manual (`GUIDE.md`) in the vault root.

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
5. Follow the prompts (takes about 5 minutes)

The installer handles Homebrew (a Mac package manager), Claude Code, Obsidian, plugins, and configuration. After that, `/bootstrap` runs an interview that asks about your role, team, and work, then builds a personalized vault with the right folder structure and configuration.

Once bootstrap finishes, run `/startday` and you're working.

## What's included

- **33 slash commands** for daily workflow, meeting ingestion, task management, triage, discovery, scaffolding, and maintenance
- **5 AI skill files** that Claude Code reads before writing vault content
- **12 templates** for daily notes, clients, projects, people, meetings, domains, decisions, RFPs, and initiatives
- **5 guides** with step-by-step walkthroughs (see above)
- **4 live dashboards** for clients, projects, daily notes, and the intake inbox
- **8 Obsidian plugins**, pre-configured
- **Session start hook** that loads your daily context when Claude Code opens
- **Interactive installer** and **bootstrap interview** to get everything set up and personalized

<details>
<summary><strong>Full command reference (33 commands)</strong></summary>

### Daily workflow
| Command | What it does |
|---------|-------------|
| `/startday` | Creates daily note, pulls open tasks, generates prioritized plan |
| `/closeday` | Summarizes accomplishments, carries over tasks, captures career evidence |
| `/capture [text]` | Routes natural language to the right section: tasks, ideas, or observations |

### Meetings
| Command | What it does |
|---------|-------------|
| `/ingest-meeting` | Structures a transcript, extracts action items, routes to client/project |
| `/ingest-batch` | Process multiple meetings in sequence |

### Triage
| Command | What it does |
|---------|-------------|
| `/triage` | Sweep all unprocessed items: meetings, notes, web clips |
| `/triage-tasks` | Batch review accumulated tasks by workstream |
| `/process [note]` | Make any note vault-native (links, metadata, formatting) |

### Context
| Command | What it does |
|---------|-------------|
| `/context` | Full vault briefing, everything that's active |
| `/context-load [target]` | Deep-dive on one client, project, or topic |

### Thinking and discovery
| Command | What it does |
|---------|-------------|
| `/ghost [question]` | Answer a question in your voice, based on vault history |
| `/challenge [topic]` | Stress-test your thinking, find contradictions and blind spots |
| `/trace [topic]` | Timeline of how an idea evolved across the vault |
| `/connect [A] and [B]` | Find hidden links between two topics |
| `/drift` | Surface recurring themes you haven't consciously noticed |
| `/emerge` | Find clusters of ideas forming into something bigger |
| `/ideas` | Full idea generation pass |

### Scaffolding
| Command | What it does |
|---------|-------------|
| `/new-client [name]` | Set up a new client with folder structure and hub note |
| `/new-project [parent] [name]` | Set up a project under a client or initiative |
| `/new-initiative [name]` | Set up a strategic initiative with sub-projects |
| `/new-domain [name]` | Set up a knowledge domain |
| `/new-code [path] [repo] [url]` | Register a codebase |
| `/bridge [code-path]` | Connect code docs to the vault graph |
| `/sync-instructions [project]` | Re-derive project instructions from hub note |

### Maintenance
| Command | What it does |
|---------|-------------|
| `/graduate` | Promote ideas from daily notes to permanent notes |
| `/relink [file]` | Add missing links to a note |
| `/audit` | Vault health scan (7 dimensions, auto-fix mode) |
| `/weekly-review` | Week in review, drift check, next week priorities |
| `/commit` | Git commit and push |

</details>

## Vault structure

Everything lives in one folder:

```
/vault
  /work                    ← Clients/teams and internal projects
    /clients/[name]/       ← One folder per client: hub note + meetings + projects
    /[company]/            ← Your company's internal work: admin, team, projects, initiatives
  /people/                 ← Person pages organized by company/context
  /domains/                ← Knowledge areas, professional and personal
  /daily-notes/            ← One note per day, the core working surface
  /intake/                 ← Unprocessed items waiting to be filed
  /agent-output/           ← Where the AI writes. You review and promote to permanent locations.
  /templates/              ← Note templates for every type
  /_meta/                  ← System docs, entity registry, guides
  /code/                   ← Links to active code project docs
  /.claude/                ← AI commands, skill references, hooks
```

## This is a starting point

This system reflects how I work. The folder structure, the commands, the daily note format. All of it is personal. You should change it.

- Restructure folders to match how you think
- Modify commands by editing the markdown files in `/.claude/commands/`
- Add new commands for your own workflows
- Change templates to match your note-taking style

You can do all of this in Claude Code. Just tell it what you want ("I want the daily note to have a different layout" or "build me a command that does X") and it'll help you make it. Everything is plain markdown files. Nothing is locked down.

## Attribution

The starting point for KP/OS was **Vin Verma**'s work ([@internetvin](https://x.com/internetvin) · [internetvin.com](https://internetvin.com)) on using an Obsidian vault as a knowledge graph for Claude Code. The discovery commands (`/ghost`, `/challenge`, `/emerge`, `/drift`, `/ideas`, `/trace`, `/connect`, `/graduate`) come from his framework. Watch the original walkthrough: [How I Use Obsidian + Claude Code to Run My Life](https://www.youtube.com/watch?v=6MBq1paspVU) (The Startup Ideas Podcast with Greg Isenberg).

Everything else (the client-project architecture, meeting ingestion pipeline, task management with deduplication, triage system, scaffolding commands, Claude.ai integration layer, entity registry routing, career evidence capture, vault auditing, the bootstrap interview, and the daily note workflow) I built to run my own job and packaged here for others.

## Requirements

- macOS (the installer uses Homebrew)
- [Obsidian](https://obsidian.md) (installed by setup.sh)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (installed by setup.sh)
- An Anthropic API key or Claude subscription ([console.anthropic.com](https://console.anthropic.com))

## License

MIT
