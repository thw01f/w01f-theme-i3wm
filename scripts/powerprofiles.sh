#!/bin/bash
if [ "$1" = "--menu" ]; then
    CHOICE=$(echo -e "Performance\nBalanced\nPower-Saver" | rofi -dmenu -i -p "Power Profile" -theme-str 'window {width: 280px; height: 160px; location: northeast; y-offset: 40px; x-offset: -20px;}')
    case "$CHOICE" in
        Performance) powerprofilesctl set performance ;;
        Balanced) powerprofilesctl set balanced ;;
        Power-Saver) powerprofilesctl set power-saver ;;
    esac
    exit 0
fi

if command -v powerprofilesctl &> /dev/null; then
    PROFILE=$(powerprofilesctl get)
    case "$PROFILE" in
        performance) echo "Performance" ;;
        balanced) echo "Balanced" ;;
        power-saver) echo "Saver" ;;
        *) echo "$PROFILE" ;;
    esac
else
    echo "N/A"
fi
