#!/usr/bin/env bash

# Force playerctl to look at kew specifically first, then fallback to anything else
if playerctl -l 2>/dev/null | grep -q "kew"; then
    PLAYER="kew"
else
    PLAYER=""
fi

# Get the status using our targeted player (or fallback)
if [ -n "$PLAYER" ]; then
    PLAYER_STATUS=$(playerctl --player="$PLAYER" status 2>/dev/null)
else
    PLAYER_STATUS=$(playerctl status 2>/dev/null)
fi

if [ "$PLAYER_STATUS" = "Playing" ]; then
    if [ -n "$PLAYER" ]; then
        ARTIST=$(playerctl --player="$PLAYER" metadata artist 2>/dev/null)
        TITLE=$(playerctl --player="$PLAYER" metadata title 2>/dev/null)
    else
        ARTIST=$(playerctl metadata artist 2>/dev/null)
        TITLE=$(playerctl metadata title 2>/dev/null)
    fi
    
    if [ -n "$ARTIST" ] && [ -n "$TITLE" ]; then
        echo "󰎆 $ARTIST - $TITLE"
    elif [ -n "$TITLE" ]; then
        echo "󰎆 $TITLE"
    else
        echo "󰎆 Music Playing"
    fi

elif [ "$PLAYER_STATUS" = "Paused" ]; then
    echo "󰏤 Paused"

else
    # Music is off -> read the static cached quote text
    CACHE_QUOTE="$HOME/.cache/polybar-quote-text"
    
    # If the cache file doesn't exist yet, force-run quotes.sh once to generate it
    if [ ! -f "$CACHE_QUOTE" ]; then
        bash "$HOME/.config/polybar/OurBar/quotes.sh"
    fi
    
    cat "$CACHE_QUOTE" 2>/dev/null || echo "No music playing"
fi
