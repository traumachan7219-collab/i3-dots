#!/usr/bin/env bash
CACHE="$HOME/.cache/polybar-quote"
SOURCE=$(cat "$CACHE" 2>/dev/null || echo "Unknown")
notify-send "Quote Origin" "$SOURCE" -i dialog-information
