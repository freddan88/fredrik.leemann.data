#!/usr/bin/env bash
# light-locker

mkdir -p /tmp/i3xf_autostart

if [[ $(systemd-detect-virt) == "kvm" ]]; then
  flock -xn /tmp/i3xf_autostart/15 -c /usr/bin/spice-vdagent &
fi

if [[ $(lsb_release -is) == "Debian" ]]; then
  flock -xn /tmp/i3xf_autostart/01 -c xiccd &
  flock -xn /tmp/i3xf_autostart/02 -c nm-applet &
  flock -xn /tmp/i3xf_autostart/03 -c xfce4-panel &
  flock -xn /tmp/i3xf_autostart/04 -c xfce4-clipman &
  flock -xn /tmp/i3xf_autostart/05 -c xfce4-power-manager &
  flock -xn /tmp/i3xf_autostart/06 -c start-pulseaudio-x11 &
  flock -xn /tmp/i3xf_autostart/07 -c system-config-printer-applet &
  flock -xn /tmp/i3xf_autostart/08 -c xfsettingsd --sm-client-disable &
  flock -xn /tmp/i3xf_autostart/09 -c /usr/libexec/gsd-disk-utility-notify &
  flock -xn /tmp/i3xf_autostart/10 -c /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &
  flock -xn /tmp/i3xf_autostart/11 -c /usr/libexec/at-spi-bus-launcher --launch-immediately &
  flock -xn /tmp/i3xf_autostart/12 -c /usr/libexec/evolution-data-server/evolution-alarm-notify &
  flock -xn /tmp/i3xf_autostart/13 -c /usr/share/xscreensaver/xscreensaver-wrapper.sh -no-splash &
  flock -xn /tmp/i3xf_autostart/14 -c /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi

if [[ $(lsb_release -is) == "Ubuntu" ]]; then
  # Autostart applications for Ubuntu
fi
