#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# S3 bucket name
S3_BUCKET="shadab-system-monitor-backups"

# Start message
echo "[$TIMESTAMP] Uploading backups to S3..."
echo "[$TIMESTAMP] Uploading backups to S3..." >> $LOG_DIR/backup.log

# Upload to S3 excluding .git files
aws s3 sync $BACKUP_DIR s3://$S3_BUCKET/backups/ \
    --exclude "*.git*" \
    --exclude "*/.git/*"

# Success message
echo "[$TIMESTAMP] S3 upload complete!"
echo "[$TIMESTAMP] S3 upload complete!" >> $LOG_DIR/backup.log
