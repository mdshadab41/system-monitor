#!/bin/bash

# Load config
source /home/cloudshell-user/system-monitor/config/config.cfg

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo "   SYSTEM MONITOR - $TIMESTAMP"
echo "========================================"

echo ""
echo "--- CPU ---"
bash /home/cloudshell-user/system-monitor/scripts/cpu_monitor.sh

echo ""
echo "--- MEMORY ---"
bash /home/cloudshell-user/system-monitor/scripts/memory_monitor.sh

echo ""
echo "--- DISK ---"
bash /home/cloudshell-user/system-monitor/scripts/disk_monitor.sh

echo ""
echo "--- NETWORK ---"
bash /home/cloudshell-user/system-monitor/scripts/network_monitor.sh

echo ""
echo "========================================"
echo "   END OF REPORT"
echo "========================================"

# Log master entry
echo "[$TIMESTAMP] Full system check completed" >> /home/cloudshell-user/system-monitor/logs/monitor.log
