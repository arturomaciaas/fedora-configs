#!/bin/bash
if pgrep -x hyprsunset > /dev/null; then
    pkill hyprsunset
    notify-send "Night Light" "Blue light filter disabled"
else
    hyprsunset -t 2500 &
    notify-send "Night Light" "Blue light filter enabled"
fi
