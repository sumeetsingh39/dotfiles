#!/bin/bash

CITY="Hyderabad"

# Fetch weather data
TEMP=$(curl -s "wttr.in/${CITY}?format=%t" | tr -d '+')
CONDITION=$(curl -s "wttr.in/${CITY}?format=%C")
HUMIDITY=$(curl -s "wttr.in/${CITY}?format=%h")

# Check if we got data
if [ -z "$TEMP" ] || [ -z "$CONDITION" ]; then
    echo '{"text": "❌ No data"}'
    exit 1
fi

# Map conditions to icons
case "$CONDITION" in
    *[Cc]lear*|*[Ss]unny*)
        ICON=""
        ;;
    *[Cc]loudy*|*[Oo]vercast*)
        ICON=""
        ;;
    *[Pp]artly*)
        ICON=""
        ;;
    *[Rr]ain*|*[Dd]rizzle*)
        ICON=""
        ;;
    *[Tt]hunder*|*[Ss]torm*)
        ICON=""
        ;;
    *[Ss]now*|*[Ff]lur*)
        ICON=""
        ;;
    *[Mm]ist*|*[Ff]og*|*[Hh]aze*)
        ICON=""
        ;;
    *)
        ICON=""
        ;;
esac

# Format output
echo "{\"text\": \"${ICON}  ${TEMP}\", \"tooltip\": \"${CONDITION}\\nHumidity: ${HUMIDITY}\"}"
