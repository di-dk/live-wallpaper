# Live Wallpaper

A small Wallpaper Engine style manager for animated wallpapers on Linux (Wayland).
It shows your Steam Workshop wallpapers in a thumbnail gallery and applies them with one click.

Built and tested on Pop!_OS 24.04 with the COSMIC desktop.

## Features

- Thumbnail gallery of every wallpaper in your Workshop folder, with search and a type filter
- Video wallpapers, played with [mpvpaper](https://github.com/GhostNaN/mpvpaper)
- Scene and web wallpapers, run with [linux-wallpaperengine](https://github.com/Almamu/linux-wallpaperengine)
- Per-wallpaper alignment, scale, offset and flip (live for videos)
- New Workshop downloads appear automatically
- Optional start at login

## Requirements

- Python 3 with GTK 4 bindings (`python3-gi`, `gir1.2-gtk-4.0`)
- `ffmpeg` (video thumbnails)
- `mpvpaper` at `~/.local/bin/mpvpaper` (video wallpapers)
- `linux-wallpaperengine` built in `~/.local/src/lwpe/build/output` (scene and web wallpapers, optional)
- A copy of Wallpaper Engine on Steam, for the Workshop content
- `cosmic-randr` to list monitors

## Install

```sh
./install.sh
```

This copies the app to `~/.local/bin/wallpaper-gui` and adds a "Live Wallpaper" entry to your app menu.

## Known limits

- Scene support depends on linux-wallpaperengine; not every scene renders correctly.
- Web wallpapers are untested and may show nothing.
- Scale, offset and flip only work for video wallpapers.
- Monitor detection only works on COSMIC.
