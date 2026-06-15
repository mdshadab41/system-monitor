#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Start message
echo "[$TIMESTAMP] Starting log rotation..."
echo "[$TIMESTAMP] Starting log rotation..." >> $LOG_DIR/rotation.log

# Compress log files older than 30 days
echo "Compressing old log files..."
find $LOG_DIR -name "*.log" -mtime +30 | while read FILE; do
    gzip $FILE
    echo "Compressed: $FILE"
    echo "[$TIMESTAMP] Compressed: $FILE" >> $LOG_DIR/rotation.log
done

# Delete compressed files older than 60 days
echo "Deleting old compressed files..."
find $LOG_DIR -name "*.gz" -mtime +60 -delete
echo "Deleted old .gz files"

# Completion message
echo "[$TIMESTAMP] Log rotation complete!"
echo "[$TIMESTAMP] Log rotation complete!" >> $LOG_DIR/rotation.log
