#!/bin/bash
# Displays current song info with artist and title

# Check if Spotify is running first
if ! playerctl -p spotify status &>/dev/null; then
    echo '{"text":"No music playing","class":"stopped"}'
    exit 0
fi

# Use stdbuf to disable output buffering and compact JSON format
stdbuf -oL playerctl -p spotify metadata --format '{"text":"{{artist}} - {{title}}","tooltip":"{{album}} - {{artist}} - {{title}}","alt":"{{status}}","class":"{{status}}"}' -F 2>/dev/null
