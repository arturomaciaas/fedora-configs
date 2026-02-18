#!/bin/bash

# Initial state
notified=false

while true; do
    # Find battery (usually BAT0 or BAT1)
    # We iterate but usually there's one main battery. 
    # If multiple, this alerts on any of them being low.
    for battery in /sys/class/power_supply/BAT*; do
        if [ -d "$battery" ]; then
            capacity=$(cat "$battery/capacity")
            status=$(cat "$battery/status")
            
            if [ "$status" = "Discharging" ]; then
                if [ "$capacity" -le 15 ] && [ "$notified" = "false" ]; then
                    notify-send -u critical "Battery Low" "Battery is at ${capacity}%"
                    notified=true
                fi
            else
                # Reset notification when charging or full
                # Only reset if we were previously notified to avoid constant state toggling issues? 
                # Actually simply setting to false is fine.
                notified=false
            fi
        fi
    done
    sleep 60
done
