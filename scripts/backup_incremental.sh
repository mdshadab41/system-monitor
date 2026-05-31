
#!/bin/bash

# Load config
source /home/cloudshell-user/system-monitor/config/config.cfg


# Timestamp 
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# backup destination
BACKUP_DEST="$BACKUP_DIR/incremental-$TIMESTAMP"
mkdir -p "$BACKUP_DEST"

# Start message

echo "[$TIMESTAMP] Starting incremental backup..."
echo "[$TIMESTAMP] Starting incremental backup..." >> $LOG_DIR/backup.log


# Check disk space
AVAILABLE=$(df -m $BACKUP_DIR | awk 'NR==2{print $4}')
echo "Available disk space: ${AVAILABLE}MB"

if [ "$AVAILABLE" -lt 100 ]; then
    echo "ERROR: Not enough disk space!"
    exit 1
fi

# Run incremental rsync
rsync -av --checksum \
     --exclude='.git' \
     --exclude='backups' \
     /home/cloudshell-user/system-monitor/ \
     "$BACKUP_DEST"

# Success message
echo "[$TIMESTAMP] Incremental backup complete! Saved to: $BACKUP_DEST"
echo "[$TIMESTAMP] Incremental backup complete! Saved to: $BACKUP_DEST" >> $LOG_DIR/backup.log



