#!/bin/bash

CHOICE=$(zenity --list --title="Neural DSP Launcher" --column="Plugin" "Petrucci" "Mateus Asato")

case $CHOICE in
    "Petrucci")
        env WINEPREFIX="$HOME/.wine64" wine "$HOME/.wine64/drive_c/Program Files/Neural DSP/Archetype-Petrucci-X/Archetype-Petrucci-X.exe"
        ;;
    "Mateus Asato")
        env WINEPREFIX="$HOME/.wine64" wine "$HOME/.wine64/drive_c/Program Files/Neural DSP/Archetype-Mateus-Asato/Archetype-Mateus-Asato.exe"
        ;;
esac
