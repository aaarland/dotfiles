-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")
    -- keep HDMI off by default, like the old conf's "monitor=HDMI-A-1,disabled"
    hl.exec_cmd("hyprctl keyword monitor HDMI-A-1,disabled")
end)
