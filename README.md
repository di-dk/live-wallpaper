<p align="center"><img src="docs/banner.jpg" alt="Live Wallpaper: animated wallpapers for Linux" width="100%"></p>

# Live Wallpaper

A small Wallpaper Engine style manager for animated wallpapers on Linux (Wayland).
It shows your Steam Workshop wallpapers in a thumbnail gallery and applies them with one click.

Built and tested on Pop!_OS 24.04 with the COSMIC desktop.

## Features

- Thumbnail gallery of every wallpaper in your Workshop folder, with search and a type filter
- Video wallpapers, played with [mpvpaper](https://github.com/GhostNaN/mpvpaper)
- Scene and web wallpapers, run with [linux-wallpaperengine](https://github.com/Almamu/linux-wallpaperengine)
- Each wallpaper's own settings (sliders, toggles, colours, choices), remembered per wallpaper
- A per-wallpaper switch to draw scene characters as still images, for scenes where the engine leaves them out
- For videos: alignment, scale, offset, flip, brightness, contrast, saturation, hue, gamma and speed, applied live
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

This copies the app to `~/.local/bin/wallpaper-gui`, installs its icon, and adds a
"Live Wallpaper" entry to your app menu.

## Engine patch

Web wallpapers and some scenes need fixes that are not in linux-wallpaperengine yet.
`patches/linux-wallpaperengine-fixes.patch` applies to commit `a0ddce5`:

```sh
cd ~/.local/src/lwpe
git apply /path/to/live-wallpaper/patches/linux-wallpaperengine-fixes.patch
cd build && make -j"$(nproc)" linux-wallpaperengine
```

What it changes:

- Web wallpapers start: browser helper processes get an intact copy of the arguments
- Web wallpapers receive their settings through `window.wallpaperPropertyListener`
  (JSON passed in the `LWPE_WEB_PROPERTIES` environment variable)
- Static web pages are repainted after a resize
- A malformed setting no longer stops a wallpaper from loading
- JSON files with trailing commas are accepted
- File lookups inside packages ignore upper and lower case
- `--screenshot-delay` is no longer capped at 5 frames
- `LWPE_NO_PUPPET=1` draws puppet characters as plain images (the app's still-image switch)

The app also sets `LD_LIBRARY_PATH` and `LD_PRELOAD` for web wallpapers so the engine's
bundled browser library loads correctly.

## Known limits

- Scene rendering depends on linux-wallpaperengine. In a test of 79 scenes, 75 drew a picture
  and 4 were blank; about half of the working ones were missing some elements
  (unsupported object types, shader errors, newer puppet model formats).
- Web wallpapers that use video formats the engine's browser cannot play show no video.
- Scale, offset, flip and the colour controls only work for video wallpapers.
- Changing a scene or web setting restarts that wallpaper.
- Monitor detection only works on COSMIC.

## Artwork

The icon and banner artwork were generated locally with ComfyUI.
