#!/bin/bash
source /home/cloudshell-user/system-monitor/config/config.cfg
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOST=$(cat /etc/hostname)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
MEM=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
DISK=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
RX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $2/1048576}')
TX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $10/1048576}')

REPORT="$REPORT_DIR/report_$(date '+%Y-%m-%d').html"

cat > $REPORT << 'HTML'
<html>
<head>
<title>System Health Report</title>
<style>
  body { font-family: Arial; margin: 40px; }
  h1 { color: #333; }
  table { border-collapse: collapse; width: 50%; }
  th { background: #333; color: white; padding: 10px; }
  td { padding: 10px; border: 1px solid #ddd; }
  .ok { color: green; font-weight: bold; }
  .critical { color: red; font-weight: bold; }
  .warning { color: orange; font-weight: bold; }
</style>
</head>
<body>
HTML

cat >> $REPORT << EOF
<h1>System Health Report</h1>
<p>Date: $TIMESTAMP</p>
<p>Host: $HOST</p>
<table>
  <tr><th>Metric</th><th>Value</th><th>Status</th></tr>
  <tr><td>CPU Usage</td><td>${CPU}%</td><td class="ok">OK</td></tr>
  <tr><td>Memory Usage</td><td>${MEM}%</td><td class="ok">OK</td></tr>
  <tr><td>Disk Usage</td><td>${DISK}%</td><td class="ok">OK</td></tr>
  <tr><td>Network RX</td><td>${RX}MB</td><td class="ok">OK</td></tr>
  <tr><td>Network TX</td><td>${TX}MB</td><td class="ok">OK</td></tr>
</table>
</body>
</html>
EOF

echo "Report saved to: $REPORT"
