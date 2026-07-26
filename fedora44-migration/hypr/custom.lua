hl.on("hyprland.start", function()
    hl.exec_cmd("input-remapper-control --command autoload")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("kitty -e tmux")
    hl.exec_cmd("pgrep -f battery-notify.sh > /dev/null || ~/Scripts/battery-notify.sh")
end)

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
