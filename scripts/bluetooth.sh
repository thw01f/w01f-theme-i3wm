#!/bin/bash
if [ "$1" = "--toggle" ]; then
    STATUS=$(bluetoothctl show | grep "Powered: yes")
    if [ -z "$STATUS" ]; then
        sudo systemctl start bluetooth
        bluetoothctl power on
    else
        bluetoothctl power off
    fi
    exit 0
fi

if systemctl is-active --quiet bluetooth; then
    POWERED=$(bluetoothctl show | grep "Powered: yes")
    if [ ! -z "$POWERED" ]; then
        echo "BT: ON"
    else
        echo "BT: OFF"
    fi
else
    echo "BT: DOWN"
fi
