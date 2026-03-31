# Module 5, Lesson 3: Automation and Scripting

## Making the System Run Itself

The starter kit includes three scripts. This lesson explains what they do, how to customize them, and how to build your own automation.

---

## Script 1: The Mailroom

The mailroom watches your inbox/outbox folders and sends you a notification when something new appears.

```bash
# What it does:
# 1. Scans inbox/ and outbox/ for new files
# 2. Sends macOS notification when it finds one
# 3. Keeps a ledger of files it's already seen (no duplicates)
# 4. Runs every 10 seconds in the background
```

**How to use it:**

```bash
# Start the mailroom
./scripts/mailroom.sh &

# You'll hear a notification when an agent drops a file
# in any inbox/ or outbox/ folder
```

**How to customize:**

The scan interval is at the top of the file. Change `INTERVAL=10` to check more or less frequently.

To change the notification sound, modify the `osascript` line:

```bash
# Available macOS sounds:
# "Ping" "Basso" "Blow" "Bottle" "Frog" "Funk"
# "Glass" "Hero" "Morse" "Pop" "Purr" "Sosumi"
# "Submarine" "Tink"
```

**Linux users:** Replace the `osascript` line with:

```bash
notify-send "Mailroom" "$MESSAGE"
```

---

## Script 2: Signal Owner

When an agent is blocked and needs your attention, it calls this script to send an urgent notification.

```bash
# Usage:
./scripts/signal-owner.sh "Bug found in auth flow" "Basso"
./scripts/signal-owner.sh "Build complete" "Glass"
./scripts/signal-owner.sh "BLOCKED - need API key" "Sosumi"
```

**Five signal types** with different sounds:

| Signal | Sound | When to Use |
|--------|-------|-------------|
| needs_help | Sosumi | Agent is stuck and needs input |
| bug_found | Basso | Bug discovered during build or QA |
| decision_needed | Submarine | A choice only the owner can make |
| task_complete | Glass | Feature done, ready for review |
| urgent | Funk | Something critical needs immediate attention |

**How agents use it:**

Add to your agent rules:

```markdown
## Signaling
When blocked or need owner attention:
- Run: scripts/signal-owner.sh "message" "sound"
- Classify: needs_help, bug_found, decision_needed, task_complete, urgent
- Then continue working on other tasks while waiting
```

---

## Script 3: Snapshot State

This script creates a backup of your entire team state — Source of Truth, agent configs, memory files, inbox/outbox.

```bash
# Usage:
./scripts/snapshot-state.sh

# Creates: snapshots/snapshot-2026-03-30-143022.tar.gz
# Keeps the last 10 snapshots, deletes older ones
```

**When to use it:**

- Before major changes to agent configurations
- At the end of each week (manual or cron)
- Before merging experimental branches
- Anytime you think "I should save the current state"

**Setting up automatic snapshots:**

Add a cron job to run it daily:

```bash
# Edit crontab
crontab -e

# Add this line (runs at midnight daily):
0 0 * * * /path/to/your/project/scripts/snapshot-state.sh
```

---

## Building Your Own Automation

The starter kit scripts are starting points. Here are ideas for custom automation:

### Commit Watcher

Notify you when any agent makes a commit:

```bash
#!/bin/bash
# commit-watcher.sh — Notifies on new commits

LAST_COMMIT=""
while true; do
    CURRENT=$(git log -1 --format="%H" 2>/dev/null)
    if [ -n "$CURRENT" ] && [ "$CURRENT" != "$LAST_COMMIT" ]; then
        MSG=$(git log -1 --format="%s" 2>/dev/null)
        osascript -e "display notification \"$MSG\" with title \"New Commit\" sound name \"Pop\""
        LAST_COMMIT="$CURRENT"
    fi
    sleep 15
done
```

### Status Dashboard

Generate a simple HTML dashboard from agent status files:

```bash
#!/bin/bash
# status-dashboard.sh — Generates status overview

echo "<html><body><h1>Team Status</h1>" > status.html

for agent_dir in outbox/*/; do
    AGENT=$(basename "$agent_dir")
    LATEST=$(ls -t "$agent_dir"*.md 2>/dev/null | head -1)
    if [ -n "$LATEST" ]; then
        echo "<h2>$AGENT</h2>" >> status.html
        echo "<pre>" >> status.html
        cat "$LATEST" >> status.html
        echo "</pre>" >> status.html
    fi
done

echo "</body></html>" >> status.html
echo "Dashboard generated: status.html"
```

### Memory Size Monitor

Warn when memory files get too large:

```bash
#!/bin/bash
# memory-monitor.sh — Warns on bloated memory files

MAX_LINES=400

for file in memory/*.md; do
    LINES=$(wc -l < "$file")
    if [ "$LINES" -gt "$MAX_LINES" ]; then
        AGENT=$(basename "$file" .md)
        osascript -e "display notification \"${AGENT}'s memory is ${LINES} lines (max: ${MAX_LINES}). Time to clean up.\" with title \"Memory Alert\" sound name \"Funk\""
    fi
done
```

---

## The Automation Philosophy

**Automate the boring stuff.** Notifications, backups, monitoring — these are tasks you'd forget to do manually. Scripts do them reliably every time.

**Don't automate decisions.** The owner makes decisions. Scripts surface information (notifications, dashboards, alerts) so the owner can decide faster.

**Start simple.** The three scripts in the starter kit cover 90% of automation needs. Add custom scripts only when you feel a specific pain point.

---

## Key Takeaway

Automation makes your AI team low-maintenance. The mailroom tells you when agents need attention. Signal owner handles urgent alerts. Snapshot state keeps backups. Together, they let you step away from the computer knowing you'll be notified if anything needs you.

Start with the three built-in scripts. Add custom automation only when you feel the need.

---

*End of Module 5 — Bonus Real-World Playbook. You now have everything: the system, the knowledge, and the patterns. Go build.*
