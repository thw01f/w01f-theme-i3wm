#!/bin/bash

# Define the options
options="Shutdown\nReboot\nSuspend\nLog Out"

# Feed the options into Rofi and save the selection
chosen=$(echo -e "$options" | rofi -dmenu -i -p "System")

# Execute the selected command
if [ "$chosen" = "Shutdown" ]; then
    systemctl poweroff
elif [ "$chosen" = "Reboot" ]; then
    systemctl reboot
elif [ "$chosen" = "Suspend" ]; then
    systemctl suspend
elif [ "$chosen" = "Log Out" ]; then
    i3-msg exit
fi
