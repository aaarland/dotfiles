#!/bin/bash
# Toggle the second (HDMI) monitor on/off — ported from the old waybar screen-switcher.
# Uses hyprctl eval (Lua API) since hyprland 0.57 removed "keyword monitor".
# Bind it however you like, or just run it: toggle-hdmi

HDMI="${HDMI_OUTPUT:-HDMI-A-1}"
HDMI_SCALE="${HDMI_SCALE:-2.5}"

MONITOR_DISABLED=$(hyprctl monitors all -j | jq --arg n "$HDMI" '.[] | select(.name == $n) | .disabled')

if [[ -z "$MONITOR_DISABLED" ]]; then
    echo "$HDMI not present" >&2
    exit 1
fi

if [[ $MONITOR_DISABLED == "true" ]]; then
    hyprctl eval "hl.monitor({ output = \"$HDMI\", disabled = false, mode = \"preferred\", position = \"auto\", scale = \"$HDMI_SCALE\" })"
else
    hyprctl eval "hl.monitor({ output = \"$HDMI\", disabled = true })"
fi
