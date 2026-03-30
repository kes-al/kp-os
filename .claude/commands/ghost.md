## Skills Reference

Before executing, load the `obsidian-markdown` skill for best practices on frontmatter format, wikilink syntax, callout types, and task checkbox format. All generated markdown must follow these conventions.

---

Based on the vault — notes, decisions, stated beliefs, and writing style — how would I answer this question: $ARGUMENTS

1. Scan relevant notes for stated positions, past decisions, and reasoning patterns
2. Look at how I've communicated about similar topics in meeting notes and documents
3. Draft a response that reflects my actual thinking, not generic advice

Requirements:
- Use my voice: direct, no corporate jargon, technically informed
- Reference specific decisions or notes where relevant with [[wikilinks]]
- Flag any areas where the vault shows contradictory positions
- If you don't have enough context in the vault, say so rather than guessing

## Output

**Always output the response directly in the conversation.** This is the primary delivery — don't make me go find a file.

If the response is substantial (10+ lines), also save it to `/agent-output/ghost/[topic]-[date].md` as an archival copy. Mention at the end: "Also saved to /agent-output/ghost/[filename]."

If the response is short, just output it. No file needed.
