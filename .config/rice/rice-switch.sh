#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# rice-switch.sh — swap theme across all apps
# Usage: ./rice-switch.sh [pink|cyan|orange|red|blue|green|purple|black|gray|yellow|teal|lavender|mint|nord|dracula|catppuccin|gruvbox|manga|manga-page|manga-pastel]
# ============================================================

BG="#000000"

theme="${1:-}"

declare -A ACCENT MODULE_FG FG KITTY_FG I3_BORDER BG_THEME FG_ALT
declare -A BASE SURFACE0 BLUE GREEN RED YELLOW MAUVE

# ---- Define themes ----
ACCENT[pink]="#d81b60"
MODULE_FG[pink]="#FFFFFF"
FG[pink]="#FFFFFF"
FG_ALT[pink]="#8F8F8F"
KITTY_FG[pink]="#ffb3d1"
I3_BORDER[pink]="#d81b60"

ACCENT[cyan]="#00acc1"
MODULE_FG[cyan]="#1F1F1F"
FG[cyan]="#FFFFFF"
FG_ALT[cyan]="#8F8F8F"
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

ACCENT[purple]="#bf5af2"
MODULE_FG[purple]="#FFFFFF"
FG[purple]="#FFFFFF"
KITTY_FG[purple]="#d68cff"
I3_BORDER[purple]="#bf5af2"

ACCENT[black]="#000000"
MODULE_FG[black]="#FFFFFF"
FG[black]="#FFFFFF"
KITTY_FG[black]="#e4e4e4"
I3_BORDER[black]="#1F1F1F"

ACCENT[manga]="#fd4e4e"
MODULE_FG[manga]="#FFFFFF"
FG[manga]="#FFFFFF"
FG_ALT[manga]="#8F8F8F"
KITTY_FG[manga]="#ff9e9e"
I3_BORDER[manga]="#fd4e4e"

ACCENT[manga-page]="#1A1A1A"
MODULE_FG[manga-page]="#1A1A1A"
FG[manga-page]="#1A1A1A"
FG_ALT[manga-page]="#5A5A5A"
KITTY_FG[manga-page]="#3A3A3A"
I3_BORDER[manga-page]="#1A1A1A"
BG_THEME[manga-page]="#FDF6E3"

ACCENT[manga-pastel]="#7EC8E3"
MODULE_FG[manga-pastel]="#FFFFFF"
FG[manga-pastel]="#FFFFFF"
FG_ALT[manga-pastel]="#8F8F8F"
KITTY_FG[manga-pastel]="#B8E2F0"
I3_BORDER[manga-pastel]="#7EC8E3"

ACCENT[gray]="#9E9E9E"
MODULE_FG[gray]="#FFFFFF"
FG[gray]="#FFFFFF"
FG_ALT[gray]="#616161"
KITTY_FG[gray]="#BDBDBD"
I3_BORDER[gray]="#9E9E9E"

ACCENT[yellow]="#fdd835"
MODULE_FG[yellow]="#1F1F1F"
FG[yellow]="#FFFFFF"
FG_ALT[yellow]="#8F8F8F"
KITTY_FG[yellow]="#fff59d"
I3_BORDER[yellow]="#fdd835"

ACCENT[teal]="#00897b"
MODULE_FG[teal]="#FFFFFF"
FG[teal]="#FFFFFF"
FG_ALT[teal]="#8F8F8F"
KITTY_FG[teal]="#80cbc4"
I3_BORDER[teal]="#00897b"

ACCENT[lavender]="#9575cd"
MODULE_FG[lavender]="#FFFFFF"
FG[lavender]="#FFFFFF"
FG_ALT[lavender]="#8F8F8F"
KITTY_FG[lavender]="#d1c4e9"
I3_BORDER[lavender]="#9575cd"

ACCENT[mint]="#66bb6a"
MODULE_FG[mint]="#FFFFFF"
FG[mint]="#FFFFFF"
FG_ALT[mint]="#8F8F8F"
KITTY_FG[mint]="#c8e6c9"
I3_BORDER[mint]="#66bb6a"

ACCENT[nord]="#88c0d0"
MODULE_FG[nord]="#2e3440"
FG[nord]="#eceff4"
FG_ALT[nord]="#4c566a"
KITTY_FG[nord]="#d8dee9"
I3_BORDER[nord]="#88c0d0"
BG_THEME[nord]="#2e3440"
BASE[nord]="#2e3440"
SURFACE0[nord]="#3b4252"
BLUE[nord]="#81a1c1"
GREEN[nord]="#a3be8c"
RED[nord]="#bf616a"
YELLOW[nord]="#ebcb8b"
MAUVE[nord]="#b48ead"

ACCENT[dracula]="#FF5555"
MODULE_FG[dracula]="#282a36"
FG[dracula]="#f8f8f2"
FG_ALT[dracula]="#6272a4"
KITTY_FG[dracula]="#f8f8f2"
I3_BORDER[dracula]="#FF5555"
BG_THEME[dracula]="#282a36"
BASE[dracula]="#282a36"
SURFACE0[dracula]="#44475a"
BLUE[dracula]="#6272a4"
GREEN[dracula]="#50fa7b"
RED[dracula]="#FF5555"
YELLOW[dracula]="#f1fa8c"
MAUVE[dracula]="#bd93f9"

ACCENT[catppuccin]="#f5c2e7"
MODULE_FG[catppuccin]="#1e1e2e"
FG[catppuccin]="#cdd6f4"
FG_ALT[catppuccin]="#6c7086"
KITTY_FG[catppuccin]="#cdd6f4"
I3_BORDER[catppuccin]="#f5c2e7"
BG_THEME[catppuccin]="#1e1e2e"
BASE[catppuccin]="#1e1e2e"
SURFACE0[catppuccin]="#313244"
BLUE[catppuccin]="#89b4fa"
GREEN[catppuccin]="#a6e3a1"
RED[catppuccin]="#f38ba8"
YELLOW[catppuccin]="#f9e2af"
MAUVE[catppuccin]="#cba6f7"

ACCENT[gruvbox]="#d65d0e"
MODULE_FG[gruvbox]="#282828"
FG[gruvbox]="#ebdbb2"
FG_ALT[gruvbox]="#928374"
KITTY_FG[gruvbox]="#ebdbb2"
I3_BORDER[gruvbox]="#d65d0e"
BG_THEME[gruvbox]="#282828"
BASE[gruvbox]="#282828"
SURFACE0[gruvbox]="#3c3836"
BLUE[gruvbox]="#83a598"
GREEN[gruvbox]="#8ec07c"
RED[gruvbox]="#fb4934"
YELLOW[gruvbox]="#fabd2f"
MAUVE[gruvbox]="#d3869b"

# ---- ANSI terminal colors (color0-color15) ----
declare -A C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 C15

# pink
C0[pink]="#1a1a24"; C8[pink]="#575766"
C1[pink]="#d81b60"; C9[pink]="#ff6b9d"
C2[pink]="#5f875f"; C10[pink]="#87af87"
C3[pink]="#d81b60"; C11[pink]="#ff6b9d"
C4[pink]="#5c6bc0"; C12[pink]="#7986cb"
C5[pink]="#d81b60"; C13[pink]="#ff6b9d"
C6[pink]="#00acc1"; C14[pink]="#4dd0e1"
C7[pink]="#e4e4e4"; C15[pink]="#ffffff"

# cyan
C0[cyan]="#1a1a24"; C8[cyan]="#575766"
C1[cyan]="#ef5350"; C9[cyan]="#ff8a80"
C2[cyan]="#66bb6a"; C10[cyan]="#b9f6ca"
C3[cyan]="#ffd54f"; C11[cyan]="#ffff8d"
C4[cyan]="#42a5f5"; C12[cyan]="#82b1ff"
C5[cyan]="#ab47bc"; C13[cyan]="#ea80fc"
C6[cyan]="#00acc1"; C14[cyan]="#00e5ff"
C7[cyan]="#e4e4e4"; C15[cyan]="#ffffff"

# red
C0[red]="#1a1a24"; C8[red]="#575766"
C1[red]="#dc143c"; C9[red]="#ff5252"
C2[red]="#5f875f"; C10[red]="#87af87"
C3[red]="#ffb300"; C11[red]="#ffd740"
C4[red]="#1e88e5"; C12[red]="#2979ff"
C5[red]="#e91e63"; C13[red]="#ff4081"
C6[red]="#00bcd4"; C14[red]="#18ffff"
C7[red]="#e4e4e4"; C15[red]="#ffffff"

# orange
C0[orange]="#1a1a24"; C8[orange]="#575766"
C1[orange]="#ff8c00"; C9[orange]="#ffab40"
C2[orange]="#66bb6a"; C10[orange]="#b9f6ca"
C3[orange]="#ff8c00"; C11[orange]="#ffab40"
C4[orange]="#42a5f5"; C12[orange]="#82b1ff"
C5[orange]="#ab47bc"; C13[orange]="#ea80fc"
C6[orange]="#26c6da"; C14[orange]="#84ffff"
C7[orange]="#e4e4e4"; C15[orange]="#ffffff"

# blue
C0[blue]="#1a1a24"; C8[blue]="#575766"
C1[blue]="#ef5350"; C9[blue]="#ff8a80"
C2[blue]="#66bb6a"; C10[blue]="#b9f6ca"
C3[blue]="#ffd54f"; C11[blue]="#ffff8d"
C4[blue]="#1e88e5"; C12[blue]="#2979ff"
C5[blue]="#ab47bc"; C13[blue]="#ea80fc"
C6[blue]="#26c6da"; C14[blue]="#84ffff"
C7[blue]="#e4e4e4"; C15[blue]="#ffffff"

# green
C0[green]="#1a1a24"; C8[green]="#575766"
C1[green]="#ef5350"; C9[green]="#ff8a80"
C2[green]="#43a047"; C10[green]="#a5d6a7"
C3[green]="#ffd54f"; C11[green]="#ffff8d"
C4[green]="#42a5f5"; C12[green]="#82b1ff"
C5[green]="#ab47bc"; C13[green]="#ea80fc"
C6[green]="#26c6da"; C14[green]="#84ffff"
C7[green]="#e4e4e4"; C15[green]="#ffffff"

# purple
C0[purple]="#1a1a24"; C8[purple]="#575766"
C1[purple]="#ef5350"; C9[purple]="#ff8a80"
C2[purple]="#66bb6a"; C10[purple]="#b9f6ca"
C3[purple]="#ffd54f"; C11[purple]="#ffff8d"
C4[purple]="#5c6bc0"; C12[purple]="#7986cb"
C5[purple]="#bf5af2"; C13[purple]="#d68cff"
C6[purple]="#26c6da"; C14[purple]="#84ffff"
C7[purple]="#e4e4e4"; C15[purple]="#ffffff"

# black
C0[black]="#1a1a24"; C8[black]="#575766"
C1[black]="#ef5350"; C9[black]="#ff8a80"
C2[black]="#66bb6a"; C10[black]="#b9f6ca"
C3[black]="#ffd54f"; C11[black]="#ffff8d"
C4[black]="#42a5f5"; C12[black]="#82b1ff"
C5[black]="#ab47bc"; C13[black]="#ea80fc"
C6[black]="#26c6da"; C14[black]="#84ffff"
C7[black]="#e4e4e4"; C15[black]="#ffffff"

# gray
C0[gray]="#1a1a24"; C8[gray]="#575766"
C1[gray]="#ef5350"; C9[gray]="#ff8a80"
C2[gray]="#66bb6a"; C10[gray]="#b9f6ca"
C3[gray]="#ffd54f"; C11[gray]="#ffff8d"
C4[gray]="#42a5f5"; C12[gray]="#82b1ff"
C5[gray]="#ab47bc"; C13[gray]="#ea80fc"
C6[gray]="#26c6da"; C14[gray]="#84ffff"
C7[gray]="#e4e4e4"; C15[gray]="#ffffff"

# yellow
C0[yellow]="#1a1a24"; C8[yellow]="#575766"
C1[yellow]="#ef5350"; C9[yellow]="#ff8a80"
C2[yellow]="#66bb6a"; C10[yellow]="#b9f6ca"
C3[yellow]="#fdd835"; C11[yellow]="#ffff8d"
C4[yellow]="#42a5f5"; C12[yellow]="#82b1ff"
C5[yellow]="#ab47bc"; C13[yellow]="#ea80fc"
C6[yellow]="#26c6da"; C14[yellow]="#84ffff"
C7[yellow]="#e4e4e4"; C15[yellow]="#ffffff"

# teal
C0[teal]="#1a1a24"; C8[teal]="#575766"
C1[teal]="#ef5350"; C9[teal]="#ff8a80"
C2[teal]="#66bb6a"; C10[teal]="#b9f6ca"
C3[teal]="#ffd54f"; C11[teal]="#ffff8d"
C4[teal]="#42a5f5"; C12[teal]="#82b1ff"
C5[teal]="#ab47bc"; C13[teal]="#ea80fc"
C6[teal]="#00897b"; C14[teal]="#80cbc4"
C7[teal]="#e4e4e4"; C15[teal]="#ffffff"

# lavender
C0[lavender]="#1a1a24"; C8[lavender]="#575766"
C1[lavender]="#ef5350"; C9[lavender]="#ff8a80"
C2[lavender]="#66bb6a"; C10[lavender]="#b9f6ca"
C3[lavender]="#ffd54f"; C11[lavender]="#ffff8d"
C4[lavender]="#5c6bc0"; C12[lavender]="#7986cb"
C5[lavender]="#9575cd"; C13[lavender]="#b39ddb"
C6[lavender]="#26c6da"; C14[lavender]="#84ffff"
C7[lavender]="#e4e4e4"; C15[lavender]="#ffffff"

# mint
C0[mint]="#1a1a24"; C8[mint]="#575766"
C1[mint]="#ef5350"; C9[mint]="#ff8a80"
C2[mint]="#66bb6a"; C10[mint]="#c8e6c9"
C3[mint]="#ffd54f"; C11[mint]="#ffff8d"
C4[mint]="#42a5f5"; C12[mint]="#82b1ff"
C5[mint]="#ab47bc"; C13[mint]="#ea80fc"
C6[mint]="#26c6da"; C14[mint]="#84ffff"
C7[mint]="#e4e4e4"; C15[mint]="#ffffff"

# manga
C0[manga]="#1a1a24"; C8[manga]="#575766"
C1[manga]="#fd4e4e"; C9[manga]="#ff9e9e"
C2[manga]="#66bb6a"; C10[manga]="#b9f6ca"
C3[manga]="#ffd54f"; C11[manga]="#ffff8d"
C4[manga]="#42a5f5"; C12[manga]="#82b1ff"
C5[manga]="#ff6b9d"; C13[manga]="#ff80ab"
C6[manga]="#26c6da"; C14[manga]="#84ffff"
C7[manga]="#e4e4e4"; C15[manga]="#ffffff"

# manga-page
C0[manga-page]="#d4c5a0"; C8[manga-page]="#b8a88a"
C1[manga-page]="#c0392b"; C9[manga-page]="#e74c3c"
C2[manga-page]="#27ae60"; C10[manga-page]="#2ecc71"
C3[manga-page]="#f39c12"; C11[manga-page]="#f1c40f"
C4[manga-page]="#2980b9"; C12[manga-page]="#3498db"
C5[manga-page]="#8e44ad"; C13[manga-page]="#9b59b6"
C6[manga-page]="#16a085"; C14[manga-page]="#1abc9c"
C7[manga-page]="#1A1A1A"; C15[manga-page]="#2d2d2d"

# manga-pastel
C0[manga-pastel]="#1a1a24"; C8[manga-pastel]="#575766"
C1[manga-pastel]="#ef9a9a"; C9[manga-pastel]="#ffcdd2"
C2[manga-pastel]="#a5d6a7"; C10[manga-pastel]="#c8e6c9"
C3[manga-pastel]="#fff59d"; C11[manga-pastel]="#fff9c4"
C4[manga-pastel]="#90caf9"; C12[manga-pastel]="#bbdefb"
C5[manga-pastel]="#ce93d8"; C13[manga-pastel]="#e1bee7"
C6[manga-pastel]="#80deea"; C14[manga-pastel]="#b2ebf2"
C7[manga-pastel]="#e4e4e4"; C15[manga-pastel]="#ffffff"

# nord
C0[nord]="#3b4252"; C8[nord]="#4c566a"
C1[nord]="#bf616a"; C9[nord]="#bf616a"
C2[nord]="#a3be8c"; C10[nord]="#a3be8c"
C3[nord]="#ebcb8b"; C11[nord]="#ebcb8b"
C4[nord]="#81a1c1"; C12[nord]="#81a1c1"
C5[nord]="#b48ead"; C13[nord]="#b48ead"
C6[nord]="#88c0d0"; C14[nord]="#8fbcbb"
C7[nord]="#e5e9f0"; C15[nord]="#eceff4"

# dracula
C0[dracula]="#21222c"; C8[dracula]="#6272a4"
C1[dracula]="#FF5555"; C9[dracula]="#ff6e6e"
C2[dracula]="#50fa7b"; C10[dracula]="#69ff94"
C3[dracula]="#f1fa8c"; C11[dracula]="#ffffa5"
C4[dracula]="#bd93f9"; C12[dracula]="#d6acff"
C5[dracula]="#ff79c6"; C13[dracula]="#ff92df"
C6[dracula]="#8be9fd"; C14[dracula]="#a4ffff"
C7[dracula]="#f8f8f2"; C15[dracula]="#ffffff"

# catppuccin
C0[catppuccin]="#45475a"; C8[catppuccin]="#585b70"
C1[catppuccin]="#f38ba8"; C9[catppuccin]="#f38ba8"
C2[catppuccin]="#a6e3a1"; C10[catppuccin]="#a6e3a1"
C3[catppuccin]="#f9e2af"; C11[catppuccin]="#f9e2af"
C4[catppuccin]="#89b4fa"; C12[catppuccin]="#89b4fa"
C5[catppuccin]="#f5c2e7"; C13[catppuccin]="#f5c2e7"
C6[catppuccin]="#94e2d5"; C14[catppuccin]="#94e2d5"
C7[catppuccin]="#bac2de"; C15[catppuccin]="#cdd6f4"

# gruvbox
C0[gruvbox]="#3c3836"; C8[gruvbox]="#928374"
C1[gruvbox]="#fb4934"; C9[gruvbox]="#fb4934"
C2[gruvbox]="#b8bb26"; C10[gruvbox]="#b8bb26"
C3[gruvbox]="#fabd2f"; C11[gruvbox]="#fabd2f"
C4[gruvbox]="#83a598"; C12[gruvbox]="#83a598"
C5[gruvbox]="#d3869b"; C13[gruvbox]="#d3869b"
C6[gruvbox]="#8ec07c"; C14[gruvbox]="#8ec07c"
C7[gruvbox]="#ebdbb2"; C15[gruvbox]="#fbf1c7"

# ---- Help ----
if [[ -z "$theme" ]]; then
  echo "Usage: $0 [pink|cyan|orange|red|blue|green|purple|black|manga|manga-page|manga-pastel]"
  exit 1
fi

if [[ -z "${ACCENT[$theme]:-}" ]]; then
  echo "Unknown theme: $theme. Options: pink cyan orange red blue green purple black gray yellow teal lavender mint nord dracula catppuccin gruvbox manga manga-page manga-pastel"
  exit 1
fi

AC="${ACCENT[$theme]}"
MF="${MODULE_FG[$theme]}"
KF="${KITTY_FG[$theme]}"
IB="${I3_BORDER[$theme]}"
FG="${FG[$theme]}"
BG="${BG_THEME[$theme]:-$BG}"
FG_ALT="${FG_ALT[$theme]:-#8F8F8F}"

echo "Switching to $theme ($AC)..."$'\n'

apply_all() {
  # ---- 1. Polybar colors.ini ----
  PFILE="$HOME/.config/polybar/docky/colors.ini"
  if [[ -f "$PFILE" ]]; then
    sed -i "s/background = #.*/background = $BG/g" "$PFILE"
    sed -i "s/foreground = #.*/foreground = $FG/g" "$PFILE"
    sed -i "s/foreground-alt = #.*/foreground-alt = $FG_ALT/g" "$PFILE"
    sed -i "s/module-fg = #.*/module-fg = $MF/g" "$PFILE"
    sed -i "s/primary = #.*/primary = $AC/g" "$PFILE"
    sed -i "s/secondary = #.*/secondary = $AC/g" "$PFILE"
    sed -i "s/alternate = #.*/alternate = $AC/g" "$PFILE"
    echo "  polybar colors.ini ✓"
  fi

  # ---- 2. Polybar prototype colors.ini ----
  PPFILE="$HOME/.config/polybar/OurBar/colors.ini"
  if [[ -f "$PPFILE" ]]; then
    sed -i "s/foreground = #.*/foreground = $FG/g" "$PPFILE"
    sed -i "s/foreground-alt = #.*/foreground-alt = $FG_ALT/g" "$PPFILE"
    sed -i "s/module-fg = #.*/module-fg = $MF/g" "$PPFILE"
    sed -i "s/primary = #.*/primary = $AC/g" "$PPFILE"
    sed -i "s/secondary = #.*/secondary = $AC/g" "$PPFILE"
    sed -i "s/alternate = #.*/alternate = $AC/g" "$PPFILE"
    echo "  polybar prototype colors.ini ✓"
  fi

  # ---- 3-4. Rofi ----
  for rfile in "$HOME/.config/polybar/docky/scripts/rofi/colors.rasi"; do
    if [[ -f "$rfile" ]]; then
      cat > "$rfile" <<- EOF
/* colors */

* {
  al:   #00000000;
  bg:   ${BG}FF;
  bga:  ${AC}33;
  bar:  ${MF}FF;
  fg:   ${FG}FF;
  fgalt:  ${FG_ALT}FF;
  ac:   ${AC}FF;
}
EOF
      echo "  rofi colors ✓"
    fi
  done

  # ---- 2b. Rofi Collection (rice.rasi) ----
  for RICEFILE in "$HOME/i3-dots/rofi-collection/colorscheme/rice.rasi" \
                   "$HOME/.config/rofi/colorscheme/rice.rasi"; do
    if [[ -f "$RICEFILE" ]]; then
      cat > "$RICEFILE" <<- EOF
* {
  bg0: ${BG}CC;
  bg1: #1F1F1F;
  fg0: ${FG};
  fg1: ${FG_ALT};

  red: ${AC};
  red-trans: ${AC}33;
  green: ${AC};
  green-trans: ${AC}33;
  yellow: ${AC};
  yellow-trans: ${AC}33;
  blue: ${AC};
  blue-trans: ${AC}33;
  purple: ${AC};
  purple-trans: ${AC}33;
  aqua: ${AC};
  aqua-trans: ${AC}33;
}
EOF
      echo "  rofi collection rice.rasi ✓"
    fi
  done

  # ---- 4. i3 config ----
  I3CFG="$HOME/.config/i3/config"
  if [[ -f "$I3CFG" ]]; then
    sed -i "/client\.focused[ ]\+#/c\client.focused          #${IB:1}     ${BG}     ${FG}     #${IB:1}     #${IB:1}" "$I3CFG"
    sed -i "/client\.focused_inactive[ ]\+#/c\client.focused_inactive #${IB:1}     ${BG}     ${MF}     ${BG}     ${BG}" "$I3CFG"
    sed -i "/client\.urgent[ ]\+#/c\client.urgent           #${IB:1}     ${BG}     ${FG}     #E53935     #E53935" "$I3CFG"
    echo "  i3 config ✓"
  fi

  # ---- 5. Kitty ----
  KITTY="$HOME/.config/kitty/kitty.conf"
  if [[ -f "$KITTY" ]]; then
    cat > "$KITTY" <<- EOF
# --- Fonts & Typography ---
font_family      DejaVuSansM Nerd Font Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        14.0

# Performance tweaks for crisp font rendering
disable_ligatures transparent
box_drawing_scale 0.001, 1, 1.5, 1

# --- Window Layout & Padding ---
window_padding_width  14
remember_window_size  no
initial_width         950
initial_height        600
hide_window_decorations yes

# --- Window Transparency & Blur ---
background_opacity         0.54
dynamic_background_opacity yes

# --- Smooth Cursor Configuration ---
cursor                ${IB}
cursor_text_color     ${BG}
cursor_shape          beam
cursor_beam_thickness 1.8
cursor_blink_interval 0.5
cursor_stop_blinking_after 15.0

# --- Terminal Performance & Bell Settings ---
repaint_delay    8
input_delay      2
sync_to_monitor  yes
enable_audio_bell no
window_alert_on_bell no

# --- Color Palette ---
background ${BG}
foreground ${KF}
bold_color ${AC}
selection_background  ${IB}
selection_foreground  #ffffff

# Black
color0  ${C0[$theme]}
color8  ${C8[$theme]}

# Red
color1  ${C1[$theme]}
color9  ${C9[$theme]}

# Green
color2  ${C2[$theme]}
color10 ${C10[$theme]}

# Yellow
color3  ${C3[$theme]}
color11 ${C11[$theme]}

# Blue
color4  ${C4[$theme]}
color12 ${C12[$theme]}

# Magenta
color5  ${C5[$theme]}
color13 ${C13[$theme]}

# Cyan
color6  ${C6[$theme]}
color14 ${C14[$theme]}

# White
color7  ${C7[$theme]}
color15 ${C15[$theme]}

# --- Mouse & Selection Behavior ---
url_color        ${C6[$theme]}
url_style        curly
open_url_with    default
detect_urls      yes
copy_on_select   yes

# ==========================================================================
#                         QUALITY OF LIFE SHORTCUTS
# ==========================================================================
# Quick Clipboard
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard

# Font scaling on the fly
map ctrl+equal     change_font_size all +1.0
map ctrl+minus     change_font_size all -1.0
map ctrl+kp_0      change_font_size all 0

# URL clicking shortcut
map ctrl+left click ungrabbed no_op
EOF
    echo "  kitty ✓"
  fi

  # ---- 6. Dunst ----
  DUNST="$HOME/.config/dunst/dunstrc"
  if [[ -f "$DUNST" ]]; then
    sed -i "s/frame_color = .*/frame_color = \"$AC\"/g" "$DUNST"
    sed -i "s/background = .*/background = \"${BG}\"/g" "$DUNST"
    sed -i "s/foreground = .*/foreground = \"$FG\"/g" "$DUNST"
    echo "  dunst ✓"
  fi

  # ---- 7. Neovim ----
  NVIM="$HOME/.config/nvim/init.lua"
  if [[ -f "$NVIM" ]]; then
    sed -i "s/^local pink\b.*/local pink      = \"$AC\"/" "$NVIM"
    sed -i "s/^local sap\b.*/local sap       = \"$KF\"/" "$NVIM"
    sed -i "s/^local teal\b.*/local teal      = \"$KF\"/" "$NVIM"
    sed -i "s/^local rosewater\b.*/local rosewater = \"$AC\"/" "$NVIM"
    echo "  nvim ✓"
  fi

  # ---- 7b. Neovim palette colors (only for palette themes) ----
  if [[ -n "${BASE[$theme]:-}" ]] && [[ -f "$NVIM" ]]; then
    sed -i "s/^local base\b.*/local base      = \"${BASE[$theme]}\"/" "$NVIM"
    sed -i "s/^local surface0\b.*/local surface0  = \"${SURFACE0[$theme]}\"/" "$NVIM"
    sed -i "s/^local blue\b.*/local blue      = \"${BLUE[$theme]}\"/" "$NVIM"
    sed -i "s/^local green\b.*/local green     = \"${GREEN[$theme]}\"/" "$NVIM"
    sed -i "s/^local red\b.*/local red       = \"${RED[$theme]}\"/" "$NVIM"
    sed -i "s/^local yellow\b.*/local yellow    = \"${YELLOW[$theme]}\"/" "$NVIM"
    sed -i "s/^local mauve\b.*/local mauve     = \"${MAUVE[$theme]}\"/" "$NVIM"
    echo "  nvim palette ✓"
  fi

  # ---- 8. Yazi theme ----
  YAZI="$HOME/.config/yazi/theme.toml"
  if [[ -f "$YAZI" ]]; then
    sed -i "s/cwd = .*/cwd = \"$AC\"/g" "$YAZI"
    sed -i "s/hovered = { fg = .*/hovered = { fg = \"${BG}\", bg = \"$AC\" }/g" "$YAZI"
    sed -i "s/mode_normal = .*/mode_normal = { fg = \"${BG}\", bg = \"$AC\", bold = true }/g" "$YAZI"
    sed -i "s/border = { fg = .* }/border = { fg = \"$AC\" }/g" "$YAZI"
    sed -i "s/active = { fg = .*/active = { fg = \"${BG}\", bg = \"$AC\" }/g" "$YAZI"
    sed -i "s/on = { fg = .* }/on = { fg = \"$AC\" }/g" "$YAZI"
    sed -i "s/hovered = { fg = .* }/hovered = { fg = \"${BG}\", bg = \"$AC\" }/g" "$YAZI"
    echo "  yazi ✓"
  fi

  # ---- 9. Waypaper CSS ----
  WP_CSS="$HOME/.config/waypaper/style.css"
  if [[ -f "$WP_CSS" ]]; then
    cat > "$WP_CSS" <<- EOF
window {
  background-color: ${BG};
}

button {
  background-color: ${BG};
  border: 1px solid ${FG_ALT};
  border-radius: 4px;
  padding: 2px;
}

button:hover {
  border: 1px solid ${AC};
  background-color: ${FG_ALT}22;
}

button.highlighted-button {
  border: 2px solid ${AC};
}

entry {
  background-color: ${BG};
  color: ${FG};
  border: 1px solid ${FG_ALT};
  border-radius: 4px;
  padding: 4px 8px;
}

entry:focus {
  border: 1px solid ${AC};
}

combobox button {
  background-color: ${BG};
  color: ${FG};
  border: 1px solid ${FG_ALT};
}

combobox button:hover {
  border: 1px solid ${AC};
}

combobox window,
combobox menu {
  background-color: ${BG};
  color: ${FG};
}

combobox menuitem:hover {
  background-color: ${FG_ALT}33;
}

label {
  color: ${FG};
}

scrolledwindow {
  background-color: ${BG};
}

scrollbar {
  background-color: ${BG};
}

scrollbar slider {
  background-color: ${FG_ALT};
  border-radius: 4px;
  min-width: 8px;
}

scrollbar slider:hover {
  background-color: ${AC};
}

checkbutton {
  color: ${FG};
}

checkbutton:hover {
  background-color: ${FG_ALT}22;
}

.daemon-panel label {
  color: ${FG_ALT};
  font-size: 11px;
}
EOF
    echo "  waypaper css ✓"
    # Reload waypaper CSS if running
    pkill -SIGUSR1 waypaper 2>/dev/null || true
  fi

  # ---- 11. Fastfetch ----
  FASTFETCH="$HOME/.config/fastfetch/config.jsonc"
  if [[ -f "$FASTFETCH" ]]; then
    R=$((16#${AC:1:2}))
    G=$((16#${AC:3:2}))
    B=$((16#${AC:5:2}))
    sed -E -i \
      -e "s/(2;)[0-9]+;[0-9]+;[0-9]+/\1${R};${G};${B}/g" \
      -e "s/[Rr];[Gg];[Bb]/${R};${G};${B}/g" \
      "$FASTFETCH"
    echo "  fastfetch ✓"
  fi

  # ---- 12. Reload ----
  dunstctl reload 2>/dev/null || true
  polybar-msg cmd restart 2>/dev/null || true
  i3-msg reload 2>/dev/null || true

  echo ""
  echo "✓ Switched to $theme. Background: $BG"
}

apply_all
