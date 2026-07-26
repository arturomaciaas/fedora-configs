#!/usr/bin/env bash
# Derive a readable waybar icon color from the top strip of the current
# wallpaper. Light wallpaper -> dark icons; dark wallpaper -> light icons.

set -euo pipefail

cache="$HOME/.cache/ml4w/hyprland-dotfiles/current_wallpaper"
out="$HOME/.config/waybar/wallpaper-luminance.css"

[ -f "$cache" ] || exit 0
img="$(cat "$cache")"
[ -f "$img" ] || exit 0

# Average perceived luminance (0..1) of the top 12% strip where the bar sits.
lum="$(magick "$img" -gravity North -crop '100%x12%+0+0' +repage \
    -resize 1x1! -format '%[fx:0.2126*p{0,0}.r+0.7152*p{0,0}.g+0.0722*p{0,0}.b]' info:)"

if awk "BEGIN{exit !($lum > 0.55)}"; then
    fg="#1a1a1a" # light wallpaper -> dark foreground
else
    fg="#ffffff" # dark wallpaper -> light foreground
fi

cat > "$out" <<EOF
@define-color icon_color $fg;

#clock,
#network,
#network.wifi,
#network.ethernet,
#pulseaudio,
#bluetooth,
#bluetooth.on,
#bluetooth.connected,
#bluetooth.off,
#battery,
#battery.charging,
#battery.plugged,
#custom-updates,
#custom-updates.green,
#custom-appmenu,
#power-profiles-daemon,
#workspaces button {
    color: $fg;
}
EOF
