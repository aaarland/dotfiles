#!/bin/bash
# Toggle the second (HDMI) monitor on/off — ported from the old waybar screen-switcher.
# Bind it however you like, or just run it: toggle-hdmi

HDMI="${HDMI_OUTPUT:-HDMI-A-1}"

MONITOR_DISABLED=$(hyprctl monitors all -j | jq '.[] | select(.name == "'"$HDMI"'") | .disabled')

if [[ $MONITOR_DISABLED == "true" ]]; then
    hyprctl keyword monitor "$HDMI, preferred,auto,2.5"
else
    hyprctl keyword monitor "$HDMI, disabled"
fi
