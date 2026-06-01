#!/bin/bash
while true; do
source /home/cloudshell-user/system-monitor/config/config.cfg
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'
clear
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo -e "${BOLD}========================================${NC}"
echo -e "${BOLD}     SYSTEM MONITOR DASHBOARD${NC}"
echo -e "${BOLD}     $TIMESTAMP${NC}"
echo -e "${BOLD}========================================${NC}"
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
CPU_INT=${CPU%.*}
if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    CPU_STATUS="${RED}CRITICAL${NC}"
elif [ "$CPU_INT" -ge 60 ]; then
    CPU_STATUS="${YELLOW}WARNING${NC}"
else
    CPU_STATUS="${GREEN}OK${NC}"
fi
echo -e "  CPU Usage:     ${CPU}%\t\t${CPU_STATUS}"
MEM=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
MEM_INT=${MEM%.*}
if [ "$MEM_INT" -ge "$MEMORY_THRESHOLD" ]; then
    MEM_STATUS="${RED}CRITICAL${NC}"
elif [ "$MEM_INT" -ge 60 ]; then
    MEM_STATUS="${YELLOW}WARNING${NC}"
else
    MEM_STATUS="${GREEN}OK${NC}"
fi
echo -e "  Memory Usage:  ${MEM}%\t\t${MEM_STATUS}"
DISK=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
if [ "$DISK" -ge "$DISK_THRESHOLD" ]; then
    DISK_STATUS="${RED}CRITICAL${NC}"
elif [ "$DISK" -ge 70 ]; then
    DISK_STATUS="${YELLOW}WARNING${NC}"
else
    DISK_STATUS="${GREEN}OK${NC}"
fi
echo -e "  Disk Usage:    ${DISK}%\t\t${DISK_STATUS}"
RX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $2/1048576}')
TX=$(cat /proc/net/dev | grep eth0 | awk '{printf "%.2f", $10/1048576}')
echo -e "  Network RX:    ${RX}MB\t\t${GREEN}OK${NC}"
echo -e "  Network TX:    ${TX}MB\t\t${GREEN}OK${NC}"
echo -e "${BOLD}========================================${NC}"
echo -e "  Press Ctrl+C to exit"
echo -e "${BOLD}========================================${NC}"
sleep 5
done
