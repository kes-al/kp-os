---
title: New Project Setup
type: resource
date: 2026-03-30
tags: [guide, reference]
---

# New Project Setup

Step-by-step guide for setting up a new project in the vault, from scaffold to Claude.ai integration.

## 1. Scaffold the Project

Run in Claude Code from the vault root:

```
/new-project [parent] "Project Name"
```

The parent can be:

- **A client** -- creates under `/work/clients/[client]/projects/[project]/`
  ```
  /new-project eastgate "Security Audit"
  ```
- **A internal area** -- creates under `/work/[company]/projects/[project]/`
  ```
  /new-project [company] "AI Academy"
  ```
- **An initiative or sub-area** -- creates under that entity's `/projects/` folder
  ```
  /new-project commerce "UX Review"
  /new-project health "Compliance Review"
  ```

You can add aliases at the end:
```
/new-project health "Compliance Review" MLR, DataTonic
```

This creates:
```
[parent-path]/[project-folder]/
  [Project Name].md          -- Hub note
  project-instructions.md    -- Claude.ai briefing
  /files                     -- Binary reference files
  /meetings                  -- Meeting notes
```

It also updates the entity registry, parent hub note, CLAUDE.md, and adds a kick-off task to today's daily note.

## 2. Fill in the Hub Note

Open `[Project Name].md` immediately. Do not leave it empty. Fill in at minimum:

- **Overview** -- One paragraph on what this project is and why it exists.
- **Team** -- Who is involved. Names, roles, org. Include client-side contacts for client projects.
- **Goals** -- What success looks like. 3-5 bullet points.

The other sections (Current State, Architecture/Approach, Timeline, Decision Log) can wait until after kickoff, but Overview/Team/Goals should be populated on day one.

## 3. Review project-instructions.md

The scaffold auto-generates `project-instructions.md` in the project folder. It is a self-contained briefing meant for Claude.ai -- no wikilinks, plain text only.

Open it and check these sections:

- **Project Summary** -- Will say "New project -- summary to be filled after kickoff." Replace with a real summary once you have one.
- **Key People** -- Defaults to you as project lead. Add team members with roles.
- **Relevant Entities** -- Should list clients, technologies, related projects. Add anything the scaffold missed.
- **Active Workstreams** -- Empty at creation. Fill in once work begins.

> [!tip] The project-instructions file is a derived artifact. You edit the hub note as the source of truth, then re-sync (see step 7). But for initial setup, editing project-instructions directly is fine since the hub note is also new.

## 4. Copy to Claude.ai

1. Open [claude.ai](https://claude.ai).
2. Create a new project. Name it to match the project name.
3. Open `project-instructions.md` and copy the entire file contents.
4. Paste into the project's **Custom Instructions** field.
5. Set up MCP filesystem tools pointing to the vault path:
   ```
   [VAULT_PATH]/
   ```
6. If the project has a codebase, also add filesystem access to the repo path.

> [!warning] Do not paste the hub note into Claude.ai. The hub note uses wikilinks that Claude.ai cannot resolve. Always use project-instructions.md, which is flattened to plain text.

## 5. Register a Codebase (If Applicable)

If the project has an associated code repository, run:

```
/new-code [project-path] [repo-name] [repo-url]
```

Example:
```
/new-code acme-corp/projects/rfp rfp-engine https://github.com/yourorg/rfp-engine
```

Then create a symlink from the repo's docs folder (never the entire repo) into the vault's `/code/` directory:

```bash
ln -s /path/to/repo/docs ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault/code/[company]/internal/[domain]/[project]
```

For client projects:
```bash
ln -s /path/to/repo/docs ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault/code/[company]/clients/[client]/[project]
```

> [!warning] Never symlink an entire repository. Node modules, build artifacts, and .git folders will destroy Obsidian indexing performance. Symlink only the `/docs` folder.

## 6. Bridge Code Docs to Vault

After the symlink is in place, run:

```
/bridge [code-path]
```

Example:
```
/bridge code/[company]/internal/ai-ml/rfp-engine
```

This creates a bridge note that:
- Summarizes the codebase from its README and docs
- Lists all markdown files found with descriptions
- Links to recognized entities (technologies, clients, domains)
- Saves to the project folder (e.g., `rfp-engine-code.md`)
- Updates the project hub note with a Codebases section

The bridge note connects code documentation to the vault graph without modifying any files in the repo itself.

## 7. Re-sync After Changes

When the hub note changes significantly (new team members, updated goals, shifted workstreams), regenerate the Claude.ai briefing:

```
/sync-instructions [project]
```

Accepts project name, alias, or folder name:
```
/sync-instructions commerce
/sync-instructions "Meridian RFP"
/sync-instructions bottler-summit
```

This is a full overwrite -- it re-derives every section of `project-instructions.md` from the current hub note state. After running:

1. Open the regenerated `project-instructions.md` and spot-check it.
2. Copy the full contents.
3. Replace the Custom Instructions in the corresponding Claude.ai project.

> [!tip] Make it a habit to re-sync after any significant hub note update. The Claude.ai project is only as current as the last time you pasted.

## Quick Reference Checklist

- [ ] `/new-project` to scaffold
- [ ] Fill hub note: Overview, Team, Goals
- [ ] Review project-instructions.md
- [ ] Create Claude.ai project and paste instructions
- [ ] `/new-code` if there is a codebase
- [ ] `ln -s` the docs folder into `/code/`
- [ ] `/bridge` to connect code docs to vault
- [ ] `/sync-instructions` whenever the hub note changes
