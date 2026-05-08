#!/bin/bash
# Returns appropriate icon for play/pause button

STATUS=$(playerctl -p spotify status 2>/dev/null)

case "$STATUS" in
    "Playing")
        echo '{"text": "⏸", "class": "playing", "tooltip": "Pause"}'
        ;;
    "Paused")
        echo '{"text": "▶", "class": "paused", "tooltip": "Play"}'
        ;;
    *)
        echo '{"text": "■", "class": "stopped", "tooltip": "Stopped"}'
        ;;
esac
