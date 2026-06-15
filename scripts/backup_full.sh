#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp (no spaces - underscore format)
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# Create backup destination folder
BACKUP_DEST="$BACKUP_DIR/full-$TIMESTAMP"
mkdir -p "$BACKUP_DEST"

# Start message
echo "[$TIMESTAMP] Starting full backup..."
echo "[$TIMESTAMP] Starting full backup..." >> $LOG_DIR/backup.log

# Check disk space before backup
AVAILABLE=$(df -m $BACKUP_DIR | awk 'NR==2{print $4}')
echo "Available disk space: ${AVAILABLE}MB"

if [ "$AVAILABLE" -lt 100 ]; then
    echo "ERROR: Not enough disk space!"
    echo "[$TIMESTAMP] ERROR: Not enough disk space!" >> $LOG_DIR/backup.log
    exit 1
fi

# Run rsync excluding unnecessary folders
rsync -av \
    --exclude='.git' \
    --exclude='backups' \
    /home/ssm-user/system-monitor/ \
    "$BACKUP_DEST"

# Success message
echo "[$TIMESTAMP] Full backup complete! Saved to: $BACKUP_DEST"
echo "[$TIMESTAMP] Full backup complete! Saved to: $BACKUP_DEST" >> $LOG_DIR/backup.log
