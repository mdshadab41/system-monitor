#!/bin/bash
source /home/cloudshell-user/system-monitor/config/config.cfg
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOST=$(cat /etc/hostname)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
MEM=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
DISK=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
RX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $2/1048576}')
TX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $10/1048576}')

REPORT="$REPORT_DIR/report_$(date '+%Y-%m-%d').csv"

# Header line
echo "Date,Host,CPU,Memory,Disk,RX,TX" > $REPORT

# Data line
echo "$TIMESTAMP,$HOST,$CPU,$MEM,$DISK,$RX,$TX" >> $REPORT

echo "Report saved to: $REPORT"
cat $REPORT
