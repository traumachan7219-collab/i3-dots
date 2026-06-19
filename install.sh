#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config/backup-$(date +%Y%m%d-%H%M%S)"

packages=(
  i3-wm polybar rofi kitty dunst picom feh flameshot
  playerctl brightnessctl networkmanager nm-connection-editor
  xss-lock i3lock-color thunar dex python pipewire-pulse
  ttf-fira-code ttf-jetbrains-mono-nerd ttf-iosevka-nerd
  ttf-dejavu-nerd ttf-nerd-fonts-symbols noto-fonts-emoji papirus-icon-theme
  pacman-contrib
)

echo ":: i3 Dotfiles Installer"
echo ""

# --- Distro check ---
if [ ! -f /etc/arch-release ]; then
  echo "[!] This installer is designed for Arch Linux."
  echo "    You can still copy the configs manually from the .config/ directory."
  exit 1
fi

# --- Package installation ---
echo "[*] Checking required packages..."
missing=()
for pkg in "${packages[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    missing+=("$pkg")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo "[!] Missing packages: ${missing[*]}"
  read -rp "    Install them now with pacman? [Y/n] " yn
  yn="${yn:-Y}"
  if [[ "$yn" =~ ^[Yy]$ ]]; then
    sudo pacman -S --needed "${missing[@]}"
  else
    echo "[!] Skipping package installation. You'll need to install them manually."
  fi
else
  echo "[*] All required packages are already installed."
fi

# --- Backup existing configs ---
echo ""
echo "[*] Backing up existing configs to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
for dir in i3 kitty nvim dunst rofi; do
  if [ -e "$HOME/.config/$dir" ]; then
    cp -r "$HOME/.config/$dir" "$BACKUP_DIR/$dir"
    echo "    backed up ~/.config/$dir"
  fi
done
if [ -e "$HOME/.config/polybar" ]; then
  cp -r "$HOME/.config/polybar" "$BACKUP_DIR/"
  echo "    backed up ~/.config/polybar"
fi

# --- Symlink repo configs ---
echo ""
echo "[*] Installing configs..."
for dir in i3 kitty nvim dunst polybar rofi; do
  src="$REPO_DIR/.config/$dir"
  dst="$HOME/.config/$dir"
  if [ ! -e "$src" ]; then
    echo "    [!] $src not found, skipping"
    continue
  fi
  rm -rf "$dst"
  ln -sf "$src" "$dst"
  echo "    linked $dst -> $src"
done

# --- Wallpaper ---
echo ""
echo "[*] Setting up wallpaper..."
WP_DIR="$HOME/Pictures/wallpaper"
mkdir -p "$WP_DIR"
if [ -f "$REPO_DIR/wallpapers/default.png" ]; then
  cp "$REPO_DIR/wallpapers/default.png" "$WP_DIR/default.png"
  echo "    copied wallpaper to $WP_DIR/default.png"
else
  echo "    [!] No wallpaper found in repo — update i3 config with your own path"
fi

echo ""
echo "[*] Installation complete!"
echo ""
echo "--- Post-install notes ---"
echo "1. Check your audio sink name in ~/.config/polybar/docky/modules.ini"
echo "   (pulseaudio-input, pulseaudio-output sections)."
echo "2. Check the network interface name in modules.ini (network section)."
echo "3. Reload i3 with \$mod+Shift+R or log out and back in."
echo "4. If polybar doesn't start, run: ~/.config/polybar/docky/launch.sh"
echo ""
echo "To restore old configs, copy from: $BACKUP_DIR"
