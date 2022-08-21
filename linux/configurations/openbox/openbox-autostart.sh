#!/usr/bin/env bash

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/xfce4-power-manager &
/usr/bin/xfce4-panel &
/usr/bin/nm-applet &
nitrogen --restore &
picom -b &
xfce4-panel-profiles load "$HOME"/.local/share/xfce4-panel-profiles/openbox-xfce4-panel.tar.bz2
