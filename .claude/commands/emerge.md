## Skills Reference

Before executing, load the `obsidian-markdown` skill for best practices on frontmatter format, wikilink syntax, callout types, and task checkbox format. All generated markdown must follow these conventions.

---

Analyze the vault for clusters of related ideas that are coalescing into something bigger than their individual notes.

Look for:
1. Groups of notes (3+) that share links, tags, or topics but aren't under a single project
2. Ideas from /agent-output/graduated that form a coherent theme
3. Meeting notes across different clients that point to the same underlying need
4. Technology explorations that could combine into a tool or product

Output the analysis directly in the conversation.

For each emerging cluster:
- **Name:** the potential project/essay/product
- **Contributing notes:** listed with [[wikilinks]]
- **What's forming:** describe why these notes belong together
- **Readiness:** is this ready to become a project, or does it need more input?

## Follow-up

For clusters that are ready:
- "This cluster looks project-ready. Want me to scaffold it with `/new-project [client] [name]` or `/new-project [company] [name]` for internal?"
- Show what the project hub note would look like (title, overview, connected notes)

For clusters that need more input:
- "This needs more substance before it's a project. Want me to add 'Explore [cluster name]' as a task to your daily note?"

## Archival

Also save to `/agent-output/emerge/emergence-report-[date].md`.
