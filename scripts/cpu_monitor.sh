#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | cut -d',' -f1)

# Round to integer
CPU_INT=${CPU_USAGE%.*}

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check threshold and alert
if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    STATUS="CRITICAL"
    COLOR=$RED
elif [ "$CPU_INT" -ge 60 ]; then
    STATUS="WARNING"
    COLOR=$YELLOW
else
    STATUS="OK"
    COLOR=$GREEN
fi

# Print to terminal
echo -e "${COLOR}[$TIMESTAMP] CPU Usage: ${CPU_USAGE}% - ${STATUS}${NC}"

# Log to file
echo "[$TIMESTAMP] CPU Usage: ${CPU_USAGE}% - ${STATUS}" >> /home/ssm-user/system-monitor/logs/cpu.log
