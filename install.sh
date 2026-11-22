#!/bin/sh
# Installs Live Wallpaper for the current user (no root needed).
set -e
here=$(cd "$(dirname "$0")" && pwd)
bin="$HOME/.local/bin"
apps="$HOME/.local/share/applications"
icons="$HOME/.local/share/icons/hicolor/scalable/apps"
mkdir -p "$bin" "$apps" "$icons"
install -m 755 "$here/wallpaper-gui" "$bin/wallpaper-gui"
install -m 644 "$here/icon/live-wallpaper.svg" "$icons/live-wallpaper.svg"
cat > "$apps/wallpaper-gui.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Live Wallpaper
GenericName=Animated Wallpaper Manager
Comment=Browse and apply Wallpaper Engine video, scene and web wallpapers
Exec=$bin/wallpaper-gui
Icon=live-wallpaper
Terminal=false
Categories=Graphics;
Keywords=wallpaper;background;animated;live;video;scene;engine;
StartupNotify=true
StartupWMClass=local.wallpaper.gui
EOF
echo "Installed. Open \"Live Wallpaper\" from your app menu."
