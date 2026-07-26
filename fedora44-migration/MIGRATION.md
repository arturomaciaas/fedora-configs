# Fedora 43 → 44 ML4W Migration

Backup of everything changed while migrating this laptop's ML4W Hyprland
setup after the Fedora 43 → 44 upgrade (2026-07-25).

The big change in this ML4W release: **Hyprland switched from `.conf` to Lua
(`.lua`)** config. Kitty, Waybar, and Yazi kept their normal formats. The Lua
API (`hl.config{}`, `hl.bind{}`, `hl.monitor{}`, `hl.device{}`, `hl.layer_rule{}`,
etc.) is documented in the on-system stub file `/usr/share/hypr/stubs/hl.meta.lua`.

Live configs under `~/.config/{hypr,kitty,waybar}` are symlinks into
`~/.mydotfiles/com.ml4w.dotfiles/.config/`. Edits land in the symlink target.

Each file below lists its **live path** (where it belongs on the system).

---

## Hyprland (`.conf` → `.lua`)

### `hypr/input.lua`
Live: `~/.config/hypr/input.lua`
Keyboard (dvp layout, numlock, repeat rate), mouse, and touchpad settings, plus
two per-device blocks (`hl.device{}`) for the Kensington trackball and Elan
touchpad. Translated from the old `keyboard.conf` + `input.conf`.

### `hypr/conf/keybindings/mac.lua`
Live: `~/.config/hypr/conf/keybindings/mac.lua`
Full personal keybind set translated to `hl.bind(...)`. Note: the new Lua binder
validates keysyms strictly — `XF86Lock` was invalid (silently ignored under the
old parser) and is now `XF86ScreenSaver`.

### `hypr/conf/keybinding.lua`
Live: `~/.config/hypr/conf/keybinding.lua`
Loader that selects the `mac.lua` keybinding variant.

### `hypr/conf/monitors/best.lua`
Live: `~/.config/hypr/conf/monitors/best.lua`
Dual-monitor setup (eDP-1 @ scale 2, HDMI-A-1 @ scale 1.5) as `hl.monitor{}`.

### `hypr/conf/monitor.lua`
Live: `~/.config/hypr/conf/monitor.lua`
Loader that selects the `best.lua` monitor variant.

### `hypr/conf/decorations/default.lua`
Live: `~/.config/hypr/conf/decorations/default.lua`
Window decoration. Corner **rounding set to `0`** (square corners) here.

### `hypr/custom.lua`
Live: `~/.config/hypr/custom.lua`
Auto-loaded by `hyprland.lua` if present. Contains:
- Personal autostart (`hl.on("hyprland.start", ...)`): input-remapper autoload,
  kdeconnect-indicator, `kitty -e tmux`, and a guarded `battery-notify.sh`.
- Waybar blur: `hl.layer_rule({ match = { namespace = "waybar" }, blur = true })`.

Dropped from the old autostart on purpose: `lxqt-policykit-agent` (new setup
already runs polkit-gnome) and `nwg-dock` (replaced by quickshell bar).

---

## Kitty

### `kitty/custom.conf`
Live: `~/.config/kitty/custom.conf`
Personal tweak (`ctrl+backspace` word-delete) kept in the update-safe custom
include instead of editing the managed `kitty.conf`.

---

## Zsh

The new ML4W zsh setup does `source $ZSH/oh-my-zsh.sh`, but oh-my-zsh isn't
installed (and this config never used it). Fixed via ML4W's override hooks.

### `zshrc_custom`
Live: `~/.zshrc_custom`
Personal zsh config (aliases, functions, p10k guard, plugins, keybindings).
Sourced last by `~/.zshrc`.

### `zshrc/custom/20-customization`
Live: `~/.config/zshrc/custom/20-customization`
Overrides the stock file to drop the oh-my-zsh `source` line (the cause of the
startup error) while keeping fzf, history, and the oh-my-posh prompt.

### `zshrc/custom/25-aliases`
Live: `~/.config/zshrc/custom/25-aliases`
Copy of stock aliases plus a `fastfetch` wrapper: inside tmux it uses a text
logo (`--logo-type builtin --logo fedora_small`) to avoid the kitty image
protocol leaking raw PNG bytes.

---

## Waybar

### `waybar/themes/mac-modern/`
Live: `~/.config/waybar/themes/mac-modern/`
New theme cloned from `ml4w-modern`, using a custom module layout (`config`).
Module backgrounds made transparent (override block at the end of `style.css`)
so the blur shows through. Selected via
`~/.config/ml4w/settings/waybar-theme.sh` = `/mac-modern;/mac-modern/default`.

### `waybar/wallpaper-icon-color.sh`
Live: `~/.config/waybar/wallpaper-icon-color.sh`
Samples the top 12% strip of the current wallpaper, computes perceived
luminance, and writes `wallpaper-luminance.css` with dark icons (lum > 0.55) or
light icons. Keeps icons readable on light *and* dark wallpapers.

### `waybar/wallpaper-luminance.css`
Live: `~/.config/waybar/wallpaper-luminance.css`
Generated file (imported last in `mac-modern/default/style.css`) that sets
`@icon_color` and scoped module `color` rules. Regenerated on each wallpaper
change. Scoped to bar modules only, so tooltips/hover states are unaffected.

---

## Scripts

### `scripts/waybar-toggle.zsh`
Live: `~/Scripts/waybar-toggle.zsh`
Rewritten to delegate to `~/.config/waybar/launch.sh` instead of a hardcoded
theme path, so toggling waybar respects the active theme (was reverting to
`ml4w-modern`).

---

## systemd user units

### `systemd-user/waybar-icon-color.service` + `.path`
Live: `~/.config/systemd/user/`
Path unit watches `~/.cache/ml4w/hyprland-dotfiles/current_wallpaper`; on change
it runs the luminance script. Enable with:
```
systemctl --user daemon-reload
systemctl --user enable --now waybar-icon-color.path
```

### `systemd-user/wallpaper.service`
Live: `~/.config/systemd/user/wallpaper.service`
Daily random-wallpaper timer target. Repointed from the deleted
`~/.config/hypr/scripts/wallpaper-automation.sh` to
`~/.config/ml4w/scripts/ml4w-wallpaper --random` (a clean oneshot). Paired with
the existing `wallpaper.timer`.

---

## ML4W settings

### `ml4w-settings/wallpaper-folder`
Live: `~/.config/ml4w/settings/wallpaper-folder`
Sets the random-wallpaper source to `~/Pictures/wallpapers/Polaroids`.

---

## System (requires sudo)

### `system/tlp.conf.excerpt`
Live: `/etc/tlp.conf`
On Fedora 44, power profiles are managed by **TLP**, which switched the platform
profile by power source (`performance` on AC, `low-power` on battery). Pinned
both to `performance` so it no longer changes on plug/unplug:
```
PLATFORM_PROFILE_ON_AC=performance
PLATFORM_PROFILE_ON_BAT=performance
```
Apply with `sudo tlp start`. Also ran `sudo systemctl enable tlp-pd.service` so
the waybar profile toggle persists across reboots. Original backed up on the
system at `/etc/tlp.conf.bak-*`.

---

## Related fixes (no config files, noted for reference)

- **hyprsunset** (SUPER+N nightlight) failed with missing `libhyprutils.so.13` /
  `libhyprlang.so.2`. Fixed: `sudo dnf install hyprutils hyprlang`.
- **Dolphin emulator** (self-compiled) broke on FFmpeg 7→8 / LLVM soname bumps.
  Migrated to the Flatpak (`org.DolphinEmu.dolphin-emu`); games moved to
  `~/Games/dolphin`, saves/config migrated into the flatpak sandbox, and
  `QT_SCALE_FACTOR=3` set via `flatpak override`.
