#!/bin/bash
# Fetches album art from Spotify and caches it

CACHE_FILE="/tmp/spotify_cover.jpg"
CACHE_INFO="/tmp/spotify_cover_info"
ART_URL=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)

# Exit if Spotify isn't running
if [[ -z "$ART_URL" ]]; then
    echo "/dev/null"
    exit 0
fi

# Check if we already have this album art cached
CURRENT_TRACK=$(playerctl -p spotify metadata xesam:title 2>/dev/null)
if [[ -f "$CACHE_INFO" ]] && grep -q "$CURRENT_TRACK" "$CACHE_INFO"; then
    # Same track, use cached image
    echo "$CACHE_FILE"
    exit 0
fi

# Download new album art
curl -s "$ART_URL" --output "$CACHE_FILE" 2>/dev/null
echo "$CURRENT_TRACK" > "$CACHE_INFO"
echo "$CACHE_FILE"
