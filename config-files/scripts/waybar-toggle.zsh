#!/bin/bash
if pgrep -x "waybar" > /dev/null; then
    killall waybar
else
    waybar -c ~/.config/waybar/themes/ml4w-modern/config -s ~/.config/waybar/themes/ml4w-modern/style.css &
fi
