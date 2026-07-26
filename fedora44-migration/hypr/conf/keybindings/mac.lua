local mod = "SUPER"
local printBtn = "SUPER + CTRL + SHIFT + ALT"

-- Launcher
hl.bind(printBtn .. " + TAB", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i"), { description = "Application launcher" })

-- Focus
hl.bind("ALT + H", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind("ALT + L", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind("ALT + K", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind("ALT + J", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

-- Window state
hl.bind("ALT + S", hl.dsp.layout("swapsplit"), { description = "Swap split" })
hl.bind("ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Fullscreen" })
hl.bind("ALT + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Maximize" })
hl.bind("ALT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggleallfloat.sh"), { description = "Toggle all floating" })
hl.bind("ALT + Q", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mod .. " + S", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(mod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { repeating = true, description = "Bring active window to top" })
hl.bind(printBtn .. " + U", hl.dsp.window.cycle_next(), { repeating = true, description = "Cycle windows" })

-- Move windows
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(mod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })
hl.bind(mod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window left" })
hl.bind(mod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window right" })
hl.bind(mod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
hl.bind(mod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })

-- Workspaces (relative)
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ workspace = "r+1" }), { description = "Move window to next workspace" })
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "r-1" }), { description = "Move window to previous workspace" })
hl.bind(printBtn .. " + L", hl.dsp.focus({ workspace = "r+1" }), { description = "Next workspace" })
hl.bind(printBtn .. " + H", hl.dsp.focus({ workspace = "r-1" }), { description = "Previous workspace" })

-- Applications
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("firefox"), { description = "Firefox" })
hl.bind(mod .. " + SEMICOLON", hl.dsp.exec_cmd("code"), { description = "VS Code" })
hl.bind(mod .. " + X", hl.dsp.exec_cmd("xournalpp"), { description = "Xournalpp" })
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("kitty -e tmux"), { description = "Terminal with tmux" })
hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"), { description = "Terminal with yazi" })
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("dolphin"), { description = "File manager" })
hl.bind(mod .. " + C", hl.dsp.exec_cmd("speedcrunch"), { description = "Calculator" })
hl.bind(mod .. " + D", hl.dsp.exec_cmd([[firefox --new-window "https://drive.google.com/drive/u/0/my-drive"]]), { description = "Google Drive" })

-- Display zoom
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd([[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")]]), { description = "Increase zoom" })
hl.bind(mod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd([[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")]]), { description = "Decrease zoom" })
hl.bind(mod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 0"), { description = "Reset zoom" })
hl.bind(mod .. " + N", hl.dsp.exec_cmd("~/Scripts/nightlight.zsh"), { description = "Toggle nightlight" })

-- Screenshots
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"), { description = "Screenshot" })
hl.bind(mod .. " + ALT + F", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --instant"), { description = "Instant fullscreen screenshot" })
hl.bind(mod .. " + ALT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --instant-area"), { description = "Instant area screenshot" })

-- Actions
hl.bind(mod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland" })
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/loadconfig.sh"), { description = "Reload config" })
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-animations.sh"), { description = "Toggle animations" })
hl.bind(mod .. " + CTRL + K", hl.dsp.exec_cmd("~/.config/hypr/scripts/keybindings.sh"), { description = "Show keybindings" })
hl.bind(mod .. " + ALT + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"), { description = "Toggle game mode" })
hl.bind(mod .. " + V", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-cliphist"), { description = "Clipboard manager" })
hl.bind(mod .. " + CTRL + Q", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-power"), { description = "Power menu" })
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock"), { description = "Lock screen" })
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind(mod .. " + CTRL + S", hl.dsp.exec_cmd("flatpak run com.ml4w.settings"), { description = "ML4W Settings" })

-- Wallpaper
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-wallpaper-app --random"), { description = "Random wallpaper" })
hl.bind(mod .. " + CTRL + W", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-wallpaper-app"), { description = "Wallpaper selector" })
hl.bind(mod .. " + ALT + W", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-wallpaper-automation"), { description = "Wallpaper automation" })

-- Waybar
hl.bind(printBtn .. " + W", hl.dsp.exec_cmd("~/Scripts/waybar-toggle.zsh"), { description = "Toggle waybar" })
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"), { description = "Reload waybar" })
hl.bind(mod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/toggle.sh"), { description = "Toggle waybar" })
hl.bind(mod .. " + CTRL + T", hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh"), { description = "Waybar theme switcher" })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true, description = "Lower volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { description = "Mute audio" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { description = "Mute microphone" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play/pause" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { description = "Pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track" })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), { description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), { description = "Decrease brightness" })
hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"), { description = "Increase keyboard backlight" })
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"), { description = "Decrease keyboard backlight" })

-- Hardware buttons
hl.bind("XF86Calculator", hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"), { description = "Calculator" })
hl.bind("XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind("XF86Tools", hl.dsp.exec_cmd("flatpak run com.ml4w.settings"), { description = "ML4W Settings" })
