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
- A per-wallpaper switch to draw scene characters as still images, as a fallback
- For videos: alignment, scale, offset, flip, brightness, contrast, saturation, hue, gamma and speed, applied live
- New Workshop downloads appear automatically
- A button to copy a wallpaper's name and Workshop ID
- Optional start at login
- A background watcher puts the wallpaper back after the screen locks, sleeps or a display is
  switched, and restarts it if the wallpaper program dies
- Falls back to an active display when the saved one is not connected

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
git -C src/External/glslang-WallpaperEngine apply /path/to/live-wallpaper/patches/glslang-fixes.patch
cd build && make -j"$(nproc)" linux-wallpaperengine
```

The second patch is for the shader compiler the engine bundles (its `glslang` submodule).

What it changes:

- Web wallpapers start: browser helper processes get an intact copy of the arguments
- Web wallpapers receive their settings through `window.wallpaperPropertyListener`
  (JSON passed in the `LWPE_WEB_PROPERTIES` environment variable)
- Static web pages are repainted after a resize
- A malformed setting no longer stops a wallpaper from loading
- JSON files with trailing commas are accepted
- File lookups inside packages ignore upper and lower case
- `--screenshot-delay` is no longer capped at 5 frames
- Puppet characters (animated cut-out models) now draw and move:
  - their triangles are no longer discarded by materials with back-face culling
  - the skeleton and keyframes are read from the model and applied every frame, following the
    scene's animation layers (looping, mirrored and single animations, additive layers)
  - a mesh that reaches past its layer is moved inside it so it is not cut off
  - animations are located by their header, which copes with the optional curve data that
    follows the keyframes in some models
  - more vertex layouts are read (52, 80 and 84 bytes), so older and newer models animate too
  - objects pinned to a puppet's attachment points (eyes, accessories, particles) sit on the right
    bone and follow it
- Children follow their parents for text and particles too, and are hidden with a hidden parent
- Text is placed and sized like in Wallpaper Engine, with several lines and non-Latin characters
- Properties animated on the editor's timeline (fades, moving objects) play
- Opacity, brightness and colour changes made by scripts and timelines show up while running
- Particle systems start "pre-run" when the wallpaper asks for it, and emitters can follow audio
- Workshop shaders written against HLSL's looser rules compile: mixed vector sizes, numeric
  conversions in function calls, constants computed from uniforms, multi-line macros, redefined
  helper functions, writes to shader inputs
- `LWPE_NO_PUPPET=1` draws puppet characters as plain images instead (the app's still-image switch)
- `LWPE_DUMP_SHADERS=<folder>` writes every shader that fails to compile into that folder

The app also sets `LD_LIBRARY_PATH` and `LD_PRELOAD` for web wallpapers so the engine's
bundled browser library loads correctly.

## Known limits

- Scene rendering depends on linux-wallpaperengine, and not every scene is right yet. Known gaps:
  3D models, some script-driven scenes, a few custom shaders, and effects that should be limited
  to part of an image.
- Audio-reactive particles were added but have not been checked against real playback yet.
- Web wallpapers that use video formats the engine's browser cannot play show no video.
- Scale, offset, flip and the colour controls only work for video wallpapers.
- Changing a scene or web setting restarts that wallpaper.
- Monitor detection only works on COSMIC.

## Artwork

The icon and banner artwork were generated locally with ComfyUI.
