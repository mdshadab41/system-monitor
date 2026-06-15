#!/bin/bash

# Load config
source /home/ssm-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo "   SYSTEM MONITOR - $TIMESTAMP"
echo "========================================"

echo ""
echo "--- CPU ---"
bash /home/ssm-user/system-monitor/scripts/cpu_monitor.sh

echo ""
echo "--- MEMORY ---"
bash /home/ssm-user/system-monitor/scripts/memory_monitor.sh

echo ""
echo "--- DISK ---"
bash /home/ssm-user/system-monitor/scripts/disk_monitor.sh

echo ""
echo "--- NETWORK ---"
bash /home/ssm-user/system-monitor/scripts/network_monitor.sh

echo ""
echo "========================================"
echo "   END OF REPORT"
echo "========================================"

# Log master entry
echo "[$TIMESTAMP] Full system check completed" >> /home/ssm-user/system-monitor/logs/monitor.log
