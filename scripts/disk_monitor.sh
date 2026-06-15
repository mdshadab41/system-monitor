#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Get disk usage for each partition
echo "[$TIMESTAMP] Disk Usage Report:"
echo "----------------------------------------"

df -h | grep -vE '^Filesystem|tmpfs|cdrom|overlay|devtmpfs' | while read line; do
    PARTITION=$(echo $line | awk '{print $1}')
    SIZE=$(echo $line | awk '{print $2}')
    USED=$(echo $line | awk '{print $3}')
    AVAILABLE=$(echo $line | awk '{print $4}')
    USAGE=$(echo $line | awk '{print $5}' | cut -d'%' -f1)

    # Check threshold
    if [ "$USAGE" -ge "$DISK_THRESHOLD" ]; then
        STATUS="CRITICAL"
        COLOR=$RED
    elif [ "$USAGE" -ge 70 ]; then
        STATUS="WARNING"
        COLOR=$YELLOW
    else
        STATUS="OK"
        COLOR=$GREEN
    fi

    # Print to terminal
    echo -e "${COLOR}Partition: $PARTITION | Size: $SIZE | Used: $USED | Available: $AVAILABLE | Usage: $USAGE% - $STATUS${NC}"

    # Log to file
    echo "[$TIMESTAMP] Partition: $PARTITION | Usage: $USAGE% - $STATUS" >> /home/ssm-user/system-monitor/logs/disk.log
done
echo "----------------------------------------"
