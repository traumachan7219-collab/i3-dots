#!/usr/bin/env bash
# Always shows at least 4 workspaces. Grows if more exist.
# Uses Polybar's formatting for colors and click actions.

MIN_WORKSPACES=4

# Get colors from rice-switch theme
ACCENT=$(grep "^primary = " ~/.config/polybar/OurBar/colors.ini | cut -d= -f2 | tr -d ' ')
FG=$(grep "^foreground = " ~/.config/polybar/OurBar/colors.ini | cut -d= -f2 | tr -d ' ')
FG_ALT=$(grep "^foreground-alt = " ~/.config/polybar/OurBar/colors.ini | cut -d= -f2 | tr -d ' ')

# Get i3 workspace info
FOCUSED=$(i3-msg -t get_workspaces 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
for w in data:
    if w['focused']:
        print(w['name'])
        break
" 2>/dev/null)

OCCUPIED=$(i3-msg -t get_workspaces 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(' '.join(w['name'] for w in data))
" 2>/dev/null)

# How many workspaces to show
NUM_EXIST=$(echo "$OCCUPIED" | wc -w)
NUM_SHOWN=$(( NUM_EXIST > MIN_WORKSPACES ? NUM_EXIST : MIN_WORKSPACES ))

OUTPUT=""
for i in $(seq 1 $NUM_SHOWN); do
    NAME="$i"

    if [ "$NAME" = "$FOCUSED" ]; then
        OUTPUT+="%{A1:i3-msg workspace $NAME &:}%{F${ACCENT}} ❤ %{F-}%{A}"
    elif echo "$OCCUPIED" | grep -qw "$NAME"; then
        OUTPUT+="%{A1:i3-msg workspace $NAME &:}%{F${FG}} ● %{F-}%{A}"
    else
        OUTPUT+="%{A1:i3-msg workspace $NAME &:}%{F${FG_ALT}} ○ %{F-}%{A}"
    fi
done

echo "$OUTPUT"
