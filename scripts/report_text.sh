#!/bin/bash
source /home/cloudshell-user/system-monitor/config/config.cfg
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOST=$(cat /etc/hostname)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
MEM=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
DISK=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
RX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $2/1048576}')
TX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $10/1048576}')

REPORT="$REPORT_DIR/report_$(date '+%Y-%m-%d').txt"

echo "================================" > $REPORT
echo "   SYSTEM HEALTH REPORT" >> $REPORT
echo "   Date: $TIMESTAMP" >> $REPORT
echo "   Host: $HOST" >> $REPORT
echo "================================" >> $REPORT
echo "CPU Usage:     $CPU%" >> $REPORT
echo "Memory Usage:  $MEM%" >> $REPORT
echo "Disk Usage:    $DISK%" >> $REPORT
echo "Network RX:    ${RX}MB" >> $REPORT
echo "Network TX:    ${TX}MB" >> $REPORT
echo "================================" >> $REPORT

echo "Report saved to: $REPORT"
cat $REPORT
