#!/bin/sh
DEFAULT="/home/cool/Pictures/con.png"
WS4="/home/cool/wallpapers/aurora.jpg"

feh --bg-scale "$DEFAULT"

i3-msg -t subscribe -m '[ "workspace" ]' | while read -r event; do
  name=$(echo "$event" | python3 -c "import sys,json; print(json.load(sys.stdin).get('current',{}).get('name',''))")
  if [ "$name" = "4" ]; then
    feh --bg-fill "$WS4"
  else
    feh --bg-scale "$DEFAULT"
  fi
done
