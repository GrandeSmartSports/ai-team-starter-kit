#!/bin/bash
# ============================================================
# AI Team — Signal Owner
# ============================================================
# Sends a macOS notification to get the owner's attention.
# Use this when an agent is BLOCKED and needs human input.
#
# Usage:
#   ./signal-owner.sh <agent-name> <signal-type> "<message>"
#
# Examples:
#   ./signal-owner.sh Builder needs_help "Stuck on database migration"
#   ./signal-owner.sh QA bug_found "Critical bug in checkout flow"
#   ./signal-owner.sh TeamLead decision_needed "Two approaches, need your pick"
# ============================================================

PROJECT_NAME="${AI_TEAM_PROJECT_NAME:-AI Team}"
AGENT_NAME="${1:-Unknown}"
SIGNAL_TYPE="${2:-needs_help}"
MESSAGE="${3:-Agent needs attention}"

# Map signal types to urgency
case "$SIGNAL_TYPE" in
    needs_help)
        TITLE="$PROJECT_NAME — Help Needed"
        SUBTITLE="$AGENT_NAME is blocked"
        SOUND="Glass"
        ;;
    bug_found)
        TITLE="$PROJECT_NAME — Bug Found"
        SUBTITLE="$AGENT_NAME found an issue"
        SOUND="Basso"
        ;;
    decision_needed)
        TITLE="$PROJECT_NAME — Decision Needed"
        SUBTITLE="$AGENT_NAME needs your input"
        SOUND="Ping"
        ;;
    task_complete)
        TITLE="$PROJECT_NAME — Task Complete"
        SUBTITLE="$AGENT_NAME finished work"
        SOUND="Hero"
        ;;
    urgent)
        TITLE="$PROJECT_NAME — URGENT"
        SUBTITLE="$AGENT_NAME needs you NOW"
        SOUND="Sosumi"
        ;;
    *)
        TITLE="$PROJECT_NAME — $AGENT_NAME"
        SUBTITLE="$SIGNAL_TYPE"
        SOUND="Glass"
        ;;
esac

# Send macOS notification
osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" subtitle \"$SUBTITLE\" sound name \"$SOUND\""

# Log the signal
LOG_DIR="${AI_TEAM_PROJECT_DIR:-$HOME/Desktop/MyProject}/scripts"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] SIGNAL: $AGENT_NAME ($SIGNAL_TYPE) — $MESSAGE" >> "$LOG_DIR/.signal-log"

echo "Signal sent: $TITLE — $MESSAGE"
