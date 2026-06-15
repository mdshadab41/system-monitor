#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get memory usage
TOTAL=$(free -m | awk 'NR==2{print $2}')
USED=$(free -m | awk 'NR==2{print $3}')
FREE=$(free -m | awk 'NR==2{print $4}')
MEMORY_USAGE=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')

# Round to integer
MEM_INT=${MEMORY_USAGE%.*}

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check threshold
if [ "$MEM_INT" -ge "$MEMORY_THRESHOLD" ]; then
    STATUS="CRITICAL"
    COLOR=$RED
elif [ "$MEM_INT" -ge 60 ]; then
    STATUS="WARNING"
    COLOR=$YELLOW
else
    STATUS="OK"
    COLOR=$GREEN
fi

# Print to terminal
echo -e "${COLOR}[$TIMESTAMP] Memory Usage: ${MEMORY_USAGE}% (Used: ${USED}MB / Total: ${TOTAL}MB) - ${STATUS}${NC}"

# Log to file
echo "[$TIMESTAMP] Memory Usage: ${MEMORY_USAGE}% (Used: ${USED}MB / Total: ${TOTAL}MB) - ${STATUS}" >> /home/ssm-user/system-monitor/logs/memory.log
