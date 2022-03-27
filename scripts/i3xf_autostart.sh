#!/usr/bin/env bash

# Autostart applications for Ubuntu
# light-locker

mkdir -p /tmp/i3xf_autostart

if [[ $(systemd-detect-virt) == "kvm" ]]; then
  flock -xn /tmp/i3xf_autostart/16 -c "/usr/bin/spice-vdagent" &
fi

if [[ $(lsb_release -is) == "Debian" ]]; then
  flock -xn /tmp/i3xf_autostart/01 -c "xfsettingsd --sm-client-disable" &
  flock -xn /tmp/i3xf_autostart/02 -c "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1" &
  flock -xn /tmp/i3xf_autostart/03 -c "/usr/share/xscreensaver/xscreensaver-wrapper.sh -no-splash" &
  flock -xn /tmp/i3xf_autostart/04 -c "/usr/libexec/evolution-data-server/evolution-alarm-notify" &
  flock -xn /tmp/i3xf_autostart/05 -c "/usr/libexec/at-spi-bus-launcher --launch-immediately" &
  flock -xn /tmp/i3xf_autostart/06 -c "/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd" &
  flock -xn /tmp/i3xf_autostart/07 -c "/usr/libexec/gsd-disk-utility-notify" &
  flock -xn /tmp/i3xf_autostart/08 -c "system-config-printer-applet" &
  flock -xn /tmp/i3xf_autostart/09 -c "start-pulseaudio-x11" &
  flock -xn /tmp/i3xf_autostart/10 -c "xfce4-power-manager" &
  flock -xn /tmp/i3xf_autostart/11 -c "blueman-applet" &
  flock -xn /tmp/i3xf_autostart/12 -c "xfce4-clipman" &
  flock -xn /tmp/i3xf_autostart/13 -c "xfce4-panel" &
  flock -xn /tmp/i3xf_autostart/14 -c "nm-applet" &
  flock -xn /tmp/i3xf_autostart/15 -c "xiccd" &
fi

if [[ $(lsb_release -is) == "Ubuntu" ]]; then
  flock -xn /tmp/i3xf_autostart/17 -c "/usr/libexec/ayatana-indicator-application/ayatana-indicator-application-service" &
  flock -xn /tmp/i3xf_autostart/18 -c "/usr/lib/x86_64-linux-gnu/indicator-messages/indicator-messages-service" &
  flock -xn /tmp/i3xf_autostart/19 -c "/usr/libexec/geoclue-2.0/demos/agent" &
  flock -xn /tmp/i3xf_autostart/20 -c "/usr/bin/snap userd --autostart" &
  flock -xn /tmp/i3xf_autostart/21 -c "xfce4-screensaver" &
  flock -xn /tmp/i3xf_autostart/22 -c "update-notifier" &
  flock -xn /tmp/i3xf_autostart/23 -c "xfce4-notes" &
  # Exec=sh -c 'if [ "x$XDG_SESSION_TYPE" = "xwayland" ] ; then exec env IM_CONFIG_CHECK_ENV=1 im-launch true; fi'
  # TryExec=im-launch
fi
