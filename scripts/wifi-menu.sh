#!/bin/bash

# Check if Wi-Fi is enabled
if [ "$(nmcli radio wifi)" = "disabled" ]; then
    choice=$(echo -e "Enable Wi-Fi" | rofi -dmenu -i -p "Wi-Fi" -theme-str 'window {width: 250px; height: 100px; location: northeast; y-offset: 40px; x-offset: -80px;}')
    if [ "$choice" = "Enable Wi-Fi" ]; then
        nmcli radio wifi on
    fi
    exit 0
fi

# Scan and list available networks
wifi_list=$(nmcli -f SSID,SECURITY device wifi list | sed 's/^ *//;s/ *$//' | sed '/^--/d' | awk '!seen[$0]++')

selected_network=$(echo -e "🔄 Refresh\n$wifi_list" | rofi -dmenu -i -p "Wi-Fi Networks" -theme-str 'window {width: 320px; height: 240px; location: northeast; y-offset: 40px; x-offset: -80px;}')

if [ "$selected_network" = "🔄 Refresh" ]; then
    nmcli device wifi rescan
    exec "$0"
elif [ -n "$selected_network" ]; then
    # Extract SSID name
    SSID=$(echo "$selected_network" | awk '{print $1}')
    
    # Try connecting; if it requires a password, prompt for it
    if nmcli device wifi connect "$SSID" 2>/dev/null; then
        notify-send "Wi-Fi" "Successfully connected to $SSID"
    else
        PASSWORD=$(rofi -dmenu -password -p "Password for $SSID" -theme-str 'window {width: 300px; height: 100px; location: northeast; y-offset: 40px; x-offset: -80px;}')
        if [ -n "$PASSWORD" ]; then
            nmcli device wifi connect "$SSID" password "$PASSWORD" && notify-send "Wi-Fi" "Connected to $SSID" || notify-send "Wi-Fi Error" "Failed to connect"
        fi
    fi
fi
