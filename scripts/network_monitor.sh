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

echo "[$TIMESTAMP] Network Usage Report:"
echo "----------------------------------------"

# Active connections count
CONNECTIONS=$(ss -tun | tail -n +2 | wc -l)

# Network interface stats
cat /proc/net/dev | grep -vE 'Inter|face|lo' | while read line; do
    INTERFACE=$(echo $line | awk '{print $1}' | cut -d':' -f1)
    RX_BYTES=$(echo $line | awk '{print $2}')
    TX_BYTES=$(echo $line | awk '{print $10}')

    # Convert to MB using awk instead of bc
    RX_MB=$(awk "BEGIN {printf \"%.2f\", $RX_BYTES/1048576}")
    TX_MB=$(awk "BEGIN {printf \"%.2f\", $TX_BYTES/1048576}")

    echo -e "${GREEN}Interface: $INTERFACE | Received: ${RX_MB}MB | Transmitted: ${TX_MB}MB${NC}"
    echo "[$TIMESTAMP] Interface: $INTERFACE | RX: ${RX_MB}MB | TX: ${TX_MB}MB" >> /home/ssm-user/system-monitor/logs/network.log
done

echo -e "${GREEN}Active Connections: $CONNECTIONS${NC}"
echo "[$TIMESTAMP] Active Connections: $CONNECTIONS" >> /home/ssm-user/system-monitor/logs/network.log
echo "----------------------------------------"
