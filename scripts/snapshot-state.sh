#!/bin/bash
# ============================================================
# AI Team — State Snapshot (Disaster Recovery)
# ============================================================
# Backs up critical team files, agent configurations, and state.
# Run manually or via cron for automated backups.
#
# Usage:
#   ./snapshot-state.sh
#   cron: 0 2 * * * /path/to/snapshot-state.sh >> /tmp/ai-team-snapshot.log 2>&1
# ============================================================

set -e

PROJECT_DIR="${AI_TEAM_PROJECT_DIR:-$HOME/Desktop/MyProject}"
BACKUP_DIR="$PROJECT_DIR/backups"
SNAPSHOT_DIR="$BACKUP_DIR/snapshots"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SNAPSHOT_FILE="$SNAPSHOT_DIR/team-state_$TIMESTAMP.tar.gz"

# Create backup directories
mkdir -p "$SNAPSHOT_DIR"
mkdir -p "$BACKUP_DIR/source-of-truth-history"
mkdir -p "$BACKUP_DIR/agent-configs"
mkdir -p "$BACKUP_DIR/inbox-outbox"

echo "AI Team State Snapshot — $TIMESTAMP"
echo "=================================================="

# 1. Backup Source of Truth
echo "Backing up Source of Truth..."
if [[ -f "$PROJECT_DIR/SOURCE-OF-TRUTH.md" ]]; then
    cp "$PROJECT_DIR/SOURCE-OF-TRUTH.md" "$BACKUP_DIR/source-of-truth-history/SOT_$TIMESTAMP.md"
fi

# 2. Backup all agent files
echo "Backing up agent configurations..."
for agent_file in "$PROJECT_DIR"/agents/*.md; do
    if [[ -f "$agent_file" ]]; then
        cp "$agent_file" "$BACKUP_DIR/agent-configs/" 2>/dev/null || true
    fi
done

if [[ -d "$PROJECT_DIR/agent-rules" ]]; then
    cp -r "$PROJECT_DIR/agent-rules" "$BACKUP_DIR/agent-configs/" 2>/dev/null || true
fi

# 3. Backup memory files
echo "Backing up memory files..."
if [[ -d "$PROJECT_DIR/memory" ]]; then
    cp -r "$PROJECT_DIR/memory" "$BACKUP_DIR/agent-configs/" 2>/dev/null || true
fi

# 4. Backup inbox/outbox
echo "Backing up inbox/outbox..."
if [[ -d "$PROJECT_DIR/inbox" ]]; then
    cp -r "$PROJECT_DIR/inbox" "$BACKUP_DIR/inbox-outbox/" 2>/dev/null || true
fi
if [[ -d "$PROJECT_DIR/outbox" ]]; then
    cp -r "$PROJECT_DIR/outbox" "$BACKUP_DIR/inbox-outbox/" 2>/dev/null || true
fi

# 5. Compress everything
echo "Compressing snapshot..."
tar -czf "$SNAPSHOT_FILE" -C "$BACKUP_DIR" \
    "source-of-truth-history" \
    "agent-configs" \
    "inbox-outbox" 2>/dev/null || true

# 6. Keep only last 10 snapshots
echo "Cleaning up old snapshots (keeping last 10)..."
ls -t "$SNAPSHOT_DIR"/team-state_*.tar.gz 2>/dev/null | tail -n +11 | xargs rm -f 2>/dev/null || true

# 7. Report
SNAPSHOT_SIZE=$(du -h "$SNAPSHOT_FILE" 2>/dev/null | cut -f1)
echo ""
echo "Snapshot complete!"
echo "  File: $(basename "$SNAPSHOT_FILE")"
echo "  Size: $SNAPSHOT_SIZE"
echo "  Location: $SNAPSHOT_DIR"
echo "  Snapshots kept: $(ls "$SNAPSHOT_DIR"/team-state_*.tar.gz 2>/dev/null | wc -l | tr -d ' ')"
echo "=================================================="
