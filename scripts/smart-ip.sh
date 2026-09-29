#!/bin/bash
if ip addr show dev tun0 2>/dev/null | grep -q "inet"; then
    IP=$(ip -4 addr show dev tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "VPN: $IP"
elif ip addr show dev wg0 2>/dev/null | grep -q "inet"; then
    IP=$(ip -4 addr show dev wg0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "WG: $IP"
else
    IP=$(ip -4 addr show dev wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
    if [ -z "$IP" ]; then
        IP="Disconnected"
    fi
    echo "IP: $IP"
fi
