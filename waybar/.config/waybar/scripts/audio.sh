#!/bin/bash

# Get current volume
VOLUME=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2*100)}')

# Get mute status
MUTED=$(wpctl get-volume @DEFAULT_SINK@ | grep -q MUTED && echo "true" || echo "false")

# Get active sink name
SINK=$(wpctl status | grep -A999 "Sinks:" | grep "*" | awk -F. '{print $2}' | xargs)

# Determine icon based on sink name
if [[ $SINK == *"Headphone"* ]] || [[ $SINK == *"Headset"* ]]; then
    ICON=" "
elif [[ $SINK == *"HDMI"* ]] || [[ $SINK == *"DisplayPort"* ]]; then
    ICON=""
else
    if [ $VOLUME -ge 66 ]; then
        ICON=" "
    elif [ $VOLUME -ge 33 ]; then
        ICON=" "
    else
        ICON=""
    fi
fi

# Override if muted
if [ "$MUTED" = "true" ]; then
    ICON="󰝟 "
fi

echo "{\"text\": \"${ICON} ${VOLUME}%\", \"tooltip\": \"${SINK}: ${VOLUME}%\"}"
