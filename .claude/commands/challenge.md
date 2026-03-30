## Skills Reference

Before executing, load the `obsidian-markdown` skill for best practices on frontmatter format, wikilink syntax, callout types, and task checkbox format. All generated markdown must follow these conventions.

---

Review my notes on $ARGUMENTS. Stress-test my thinking.

1. Find all notes where I've stated positions, made decisions, or expressed beliefs about this topic
2. Identify assumptions I'm making (stated or implied)
3. Look for contradictions across notes (did I say one thing in January and another in March?)
4. Check if my reasoning has gaps or if I'm ignoring counter-evidence

Output the analysis directly in the conversation with this structure:
- **My stated position** (with [[wikilinks]] to source notes)
- **Assumptions identified** (which are tested vs untested?)
- **Contradictions found** (if any)
- **Blind spots:** what am I not considering?
- **Counter-arguments:** what would a smart skeptic say?
- **Recommendation:** should I update my thinking?

## Suggest Fixes

If the challenge reveals genuine contradictions or outdated positions, don't just flag them — suggest specific updates:
- "Your note in [[Acme RFP]] says X but your meeting note from 2/15 says Y. Want me to update the project note to reflect the newer position?"
- "You've assumed X in three places but never tested it. Want me to add a task to validate this?"

List each suggested fix. Don't auto-write — ask before updating.

## Archival

If the analysis is substantial, also save to `/agent-output/challenges/[topic]-[date].md`. Mention at the end: "Also saved to /agent-output/challenges/[filename]."
