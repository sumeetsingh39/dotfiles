#!/bin/bash

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
MEM=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
TEMP=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print int($1/1000)}')

# Show icon normally, add warning if critical
ICON="󰍛"
TEXT=""
CLASS=""

if [ $CPU -gt 90 ] || [ $MEM -gt 90 ] || [ $TEMP -gt 80 ]; then
    TEXT=" ⚠"
    CLASS="critical"
fi

echo "{\"text\": \"${ICON}${TEXT}\", \"tooltip\": \"CPU: ${CPU}%\\nMemory: ${MEM}%\\nTemp: ${TEMP}°C\", \"class\": \"${CLASS}\"}"