#!/bin/bash


HDMI="HDMI-A-1"

MONITOR_DISABLED=$(hyprctl monitors all -j | jq '.[] | select(.name == "HDMI-A-1") | .disabled')

if [[ $MONITOR_DISABLED == "true" ]]; then
    hyprctl keyword monitor "$HDMI, preferred,auto,2.5"
else
    hyprctl keyword monitor "$HDMI, disabled"
fi
