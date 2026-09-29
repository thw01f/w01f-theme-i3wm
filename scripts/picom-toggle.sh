#!/bin/bash
if pgrep -x "picom" > /dev/null
then
    # If Picom is running, kill it to save battery
    killall picom
else
    # If Picom is off, start it with your aesthetic config
    picom --config ~/.config/picom/picom.conf -b
fi
