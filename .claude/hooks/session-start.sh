#!/bin/bash
# Vault Session Start Hook
# Auto-commits uncommitted changes, then loads daily context into Claude Code.

export PATH="/Applications/Obsidian.app/Contents/MacOS:/usr/local/bin:$PATH"

# Auto-commit any uncommitted vault changes (ensures at least 1 commit per day)
if [ -d .git ]; then
    if ! git diff --quiet HEAD 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        git add -A 2>/dev/null
        git reset HEAD .obsidian/plugins/various-complements/histories.json .obsidian/graph.json firebase-debug.log 2>/dev/null
        git commit -m "Auto-commit: vault changes from $(date +%Y-%m-%d)

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>" 2>/dev/null
        git push 2>/dev/null
    fi
fi

python3 << 'PYEOF'
import json
import subprocess

def run(cmd):
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)
        return result.stdout.strip() if result.returncode == 0 else ""
    except:
        return ""

daily = run("obsidian daily:read")
tasks = run("obsidian tasks daily todo")

open_tasks = [l for l in tasks.splitlines() if l.strip().startswith("- [ ]")]
high = [l for l in open_tasks if "❗" in l or "!high" in l or "\u2b06" in l]

parts = ["## Vault Session Context (auto-loaded)\n"]

if daily:
    parts.append("### Today's Daily Note")
    parts.append(daily)
else:
    parts.append("No daily note yet. Run /startday to begin the day.")

if open_tasks:
    parts.append(f"\n### Open Tasks: {len(open_tasks)} total, {len(high)} high priority")
else:
    parts.append("\nNo open tasks found.")

parts.append("\nUse /context-load [project] for deep project context.")

context = "\n".join(parts)
print(json.dumps({"additionalContext": context}))
PYEOF
