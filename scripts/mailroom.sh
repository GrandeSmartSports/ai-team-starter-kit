#!/bin/bash
# ============================================================
# AI Team Mailroom — Inbox/Outbox Watcher
# ============================================================
# Watches inbox and outbox for new files and sends macOS
# notifications so no teammate message goes unread.
#
# Usage:
#   ./mailroom.sh              # Run in foreground
#   ./mailroom.sh &            # Run in background
#   ./mailroom.sh --once       # Single check, no loop
#   ./mailroom.sh --stop       # Stop background watcher
#
# The script keeps a ledger of seen files so it only notifies
# on genuinely NEW drops.
# ============================================================

# CONFIGURE THESE PATHS for your project
PROJECT_DIR="${AI_TEAM_PROJECT_DIR:-$HOME/Desktop/MyProject}"
INBOX="$PROJECT_DIR/inbox"
OUTBOX="$PROJECT_DIR/outbox"
LEDGER="$PROJECT_DIR/scripts/.mailroom-ledger"
PIDFILE="$PROJECT_DIR/scripts/.mailroom.pid"
CHECK_INTERVAL=30  # seconds between checks
PROJECT_NAME="${AI_TEAM_PROJECT_NAME:-AI Team}"

# Initialize ledger if it doesn't exist
touch "$LEDGER"

# --stop flag: kill running watcher
if [[ "$1" == "--stop" ]]; then
    if [[ -f "$PIDFILE" ]]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            kill "$PID"
            rm -f "$PIDFILE"
            echo "Mailroom stopped (PID $PID)"
        else
            rm -f "$PIDFILE"
            echo "Mailroom was not running (stale PID)"
        fi
    else
        echo "No mailroom process found"
    fi
    exit 0
fi

# Write PID file for stop command
echo $$ > "$PIDFILE"

# Cleanup on exit
trap 'rm -f "$PIDFILE"' EXIT

notify() {
    local title="$1"
    local subtitle="$2"
    local message="$3"
    osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\" sound name \"Glass\""
}

check_directory() {
    local dir="$1"
    local label="$2"
    local new_count=0
    local new_files=""

    # Find .md files (not hidden)
    while IFS= read -r -d '' file; do
        local bname
        bname=$(basename "$file")

        # Skip hidden files and README
        if [[ "$bname" == .* ]] || [[ "$bname" == "README.md" ]]; then
            continue
        fi

        # Check if we've already seen this file
        if ! grep -qF "$file" "$LEDGER" 2>/dev/null; then
            echo "$file" >> "$LEDGER"
            new_count=$((new_count + 1))
            new_files="${new_files}  NEW ${label}: ${bname}\n"
        fi
    done < <(find "$dir" -maxdepth 2 -name "*.md" -print0 2>/dev/null)

    # Also check for other file types
    while IFS= read -r -d '' file; do
        local bname
        bname=$(basename "$file")
        if [[ "$bname" == .* ]]; then continue; fi
        if ! grep -qF "$file" "$LEDGER" 2>/dev/null; then
            echo "$file" >> "$LEDGER"
            new_count=$((new_count + 1))
            new_files="${new_files}  NEW ${label}: ${bname}\n"
        fi
    done < <(find "$dir" -maxdepth 2 \( -name "*.png" -o -name "*.jpg" -o -name "*.txt" -o -name "*.json" \) -print0 2>/dev/null)

    if [[ -n "$new_files" ]]; then
        printf "%b" "$new_files" >&2
    fi

    echo "$new_count"
}

run_check() {
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    echo "[$timestamp] Checking mailroom..." >&2

    local inbox_new outbox_new
    inbox_new=$(check_directory "$INBOX" "INBOX")
    outbox_new=$(check_directory "$OUTBOX" "OUTBOX")

    if [[ "$inbox_new" -gt 0 ]] && [[ "$outbox_new" -gt 0 ]]; then
        notify "$PROJECT_NAME Mailroom" "New Mail!" "$inbox_new new in inbox, $outbox_new new in outbox"
    elif [[ "$inbox_new" -gt 0 ]]; then
        notify "$PROJECT_NAME Mailroom" "Inbox" "$inbox_new new message(s) in inbox"
    elif [[ "$outbox_new" -gt 0 ]]; then
        notify "$PROJECT_NAME Mailroom" "Outbox" "$outbox_new new message(s) in outbox"
    else
        echo "  No new mail." >&2
    fi
}

# Single check mode
if [[ "$1" == "--once" ]]; then
    run_check
    rm -f "$PIDFILE"
    exit 0
fi

# Continuous watch mode
echo "============================================" >&2
echo "  $PROJECT_NAME Mailroom — Watching..." >&2
echo "  Inbox:  $INBOX" >&2
echo "  Outbox: $OUTBOX" >&2
echo "  Check every ${CHECK_INTERVAL}s" >&2
echo "  PID: $$" >&2
echo "  Stop: ./mailroom.sh --stop" >&2
echo "============================================" >&2

run_check

while true; do
    sleep "$CHECK_INTERVAL"
    run_check
done
