#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# rice-switch.sh — swap theme across all apps
# Usage: ./rice-switch.sh [pink|cyan|orange|crimson|blue|green|black]
# ============================================================

BG="#1F1F1F"

theme="${1:-}"

declare -A ACCENT MODULE_FG FG KITTY_FG I3_BORDER

# ---- Define themes ----
ACCENT[pink]="#d81b60"
MODULE_FG[pink]="#FFFFFF"
FG[pink]="#FFFFFF"
KITTY_FG[pink]="#ffb3d1"
I3_BORDER[pink]="#d81b60"

ACCENT[cyan]="#00acc1"
MODULE_FG[cyan]="#1F1F1F"
FG[cyan]="#FFFFFF"
KITTY_FG[cyan]="#3BE2FF"
I3_BORDER[cyan]="#00acc1"

ACCENT[red]="#dc143c"
MODULE_FG[red]="#FFFFFF"
FG[red]="#FFFFFF"
KITTY_FG[red]="#dc143c"
I3_BORDER[red]="#dc143c"

ACCENT[orange]="#ff8c00"
MODULE_FG[orange]="#1F1F1F"
FG[orange]="#FFFFFF"
KITTY_FG[orange]="#ffb74d"
I3_BORDER[orange]="#ff8c00"

ACCENT[crimson]="#dc143c"
MODULE_FG[crimson]="#FFFFFF"
FG[crimson]="#FFFFFF"
KITTY_FG[crimson]="#ef5350"
I3_BORDER[crimson]="#dc143c"

ACCENT[blue]="#1e88e5"
MODULE_FG[blue]="#FFFFFF"
FG[blue]="#FFFFFF"
KITTY_FG[blue]="#82b1ff"
I3_BORDER[blue]="#1e88e5"

ACCENT[green]="#43a047"
MODULE_FG[green]="#FFFFFF"
FG[green]="#FFFFFF"
KITTY_FG[green]="#a5d6a7"
I3_BORDER[green]="#43a047"

ACCENT[black]="#000000"
MODULE_FG[black]="#FFFFFF"
FG[black]="#FFFFFF"
KITTY_FG[black]="#e4e4e4"
I3_BORDER[black]="#1F1F1F"

# ---- Help ----
if [[ -z "$theme" ]]; then
  echo "Usage: $0 [pink|cyan|orange|red|crimson|blue|green|black]"
  exit 1
fi

if [[ -z "${ACCENT[$theme]:-}" ]]; then
  echo "Unknown theme: $theme. Options: pink cyan orange red crimson blue green black"
  exit 1
fi

AC="${ACCENT[$theme]}"
MF="${MODULE_FG[$theme]}"
KF="${KITTY_FG[$theme]}"
IB="${I3_BORDER[$theme]}"
FG="${FG[$theme]}"

echo "Switching to $theme ($AC)..."$'\n'

apply_all() {
  # ---- 1. Polybar colors.ini ----
  PFILE="$HOME/.config/polybar/docky/colors.ini"
  if [[ -f "$PFILE" ]]; then
    sed -i "s/background = #.*/background = $BG/g" "$PFILE"
    sed -i "s/foreground = #.*/foreground = $FG/g" "$PFILE"
    sed -i "s/foreground-alt = #.*/foreground-alt = #8F8F8F/g" "$PFILE"
    sed -i "s/module-fg = #.*/module-fg = $MF/g" "$PFILE"
    sed -i "s/primary = #.*/primary = $AC/g" "$PFILE"
    sed -i "s/secondary = #.*/secondary = $AC/g" "$PFILE"
    sed -i "s/alternate = #.*/alternate = $AC/g" "$PFILE"
    echo "  polybar colors.ini ✓"
  fi

  # ---- 2-3. Rofi ----
  for rfile in "$HOME/.config/polybar/docky/scripts/rofi/colors.rasi" \
               "$HOME/.config/rofi/colors.rasi"; do
    if [[ -f "$rfile" ]]; then
      cat > "$rfile" <<- EOF
/* colors */

* {
  al:   #00000000;
  bg:   ${BG}FF;
  bga:  ${AC}33;
  bar:  ${MF}FF;
  fg:   #FFFFFFFF;
  ac:   ${AC}FF;
}
EOF
      echo "  rofi ✓"
    fi
  done

  # ---- 4. i3 config ----
  I3CFG="$HOME/.config/i3/config"
  if [[ -f "$I3CFG" ]]; then
    sed -i "/client\.focused[ ]\+#/c\client.focused          #${IB:1}     ${BG}     #FFFFFF     #${IB:1}     #${IB:1}" "$I3CFG"
    sed -i "/client\.focused_inactive[ ]\+#/c\client.focused_inactive #${IB:1}     ${BG}     #8F8F8F     ${BG}     ${BG}" "$I3CFG"
    sed -i "/client\.urgent[ ]\+#/c\client.urgent           #${IB:1}     ${BG}     #FFFFFF     #E53935     #E53935" "$I3CFG"
    echo "  i3 config ✓"
  fi

  # ---- 5. Kitty ----
  KITTY="$HOME/.config/kitty/kitty.conf"
  if [[ -f "$KITTY" ]]; then
    sed -i "s/foreground #.*/foreground $KF/g" "$KITTY"
    sed -i "s/background #.*/background ${BG}/g" "$KITTY"
    sed -i "0,/cursor[ ]*#[0-9a-fA-F]*/s//cursor                #${IB:1}/" "$KITTY"
    sed -i "s/selection_background[ ]*#[0-9a-fA-F]*/selection_background  #${IB:1}/g" "$KITTY"
    sed -i "s/color1[ ]*#[0-9a-fA-F]*/color1  #${IB:1}/g" "$KITTY"
    sed -i "s/color9[ ]*#[0-9a-fA-F]*/color9  #${IB:1}/g" "$KITTY"
    echo "  kitty ✓"
  fi

  # ---- 6. Dunst ----
  DUNST="$HOME/.config/dunst/dunstrc"
  if [[ -f "$DUNST" ]]; then
    sed -i "s/frame_color = .*/frame_color = \"$AC\"/g" "$DUNST"
    sed -i "s/background = .*/background = \"${BG}\"/g" "$DUNST"
    sed -i "s/foreground = .*/foreground = \"#FFFFFF\"/g" "$DUNST"
    echo "  dunst ✓"
  fi

  # ---- 7. Yazi theme ----
  YAZI="$HOME/.config/yazi/theme.toml"
  if [[ -f "$YAZI" ]]; then
    sed -i "s/cwd = .*/cwd = \"$AC\"/g" "$YAZI"
    sed -i "s/hovered = { fg = .*/hovered = { fg = \"$KF\", bg = \"$AC\" }/g" "$YAZI"
    sed -i "s/mode_normal = .*/mode_normal = { fg = \"${BG}\", bg = \"$AC\", bold = true }/g" "$YAZI"
    sed -i "s/border = { fg = .* }/border = { fg = \"$AC\" }/g" "$YAZI"
    sed -i "s/active = { fg = .*/active = { fg = \"$KF\", bg = \"$AC\" }/g" "$YAZI"
    sed -i "s/on = { fg = .* }/on = { fg = \"$AC\" }/g" "$YAZI"
    sed -i "s/hovered = { fg = .* }/hovered = { fg = \"${BG}\", bg = \"$AC\" }/g" "$YAZI"
    echo "  yazi ✓"
  fi

  # ---- 8. Reload ----
  killall -USR1 dunst 2>/dev/null || true
  polybar-msg cmd restart 2>/dev/null || true
  i3-msg reload 2>/dev/null || true

  echo ""
  echo "✓ Switched to $theme. Background: $BG"
}

apply_all
