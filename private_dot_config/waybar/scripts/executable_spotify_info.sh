#!/bin/bash
# Displays current song info with artist and title

playerctl -p spotify metadata --format '{
  "text": "{{artist}} - {{title}}",
  "tooltip": "{{album}}\n{{artist}} - {{title}}",
  "alt": "{{status}}",
  "class": "{{status}}"
}' -F 2>/dev/null

# Fallback if Spotify isn't running
if [[ $? -ne 0 ]]; then
    echo '{"text": "No music playing", "class": "stopped"}'
fi
