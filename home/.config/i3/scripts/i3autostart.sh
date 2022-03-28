#!/usr/bin/env bash
# Autostart applications

tmp_directory="/tmp/i3autostart"
mkdir -p $tmp_directory

if [ -f "$HOME/.config/i3/scripts/i3keybindings.sh" ]; then
  $HOME/.config/i3/scripts/i3keybindings.sh
fi

if [[ $(systemd-detect-virt) == "kvm" ]]; then
  flock -xn $tmp_directory/00 -c "/usr/bin/spice-vdagent" &
fi

flock -xn $tmp_directory/01 -c "xfsettingsd --sm-client-disable" &
flock -xn $tmp_directory/02 -c "/usr/libexec/at-spi-bus-launcher --launch-immediately" &
flock -xn $tmp_directory/03 -c "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1" &
flock -xn $tmp_directory/04 -c "/usr/libexec/evolution-data-server/evolution-alarm-notify" &
flock -xn $tmp_directory/05 -c "/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd" &
flock -xn $tmp_directory/06 -c "system-config-printer-applet" &
flock -xn $tmp_directory/07 -c "start-pulseaudio-x11" &
flock -xn $tmp_directory/08 -c "xfce4-power-manager" &
flock -xn $tmp_directory/09 -c "blueman-applet" &
flock -xn $tmp_directory/10 -c "xfce4-clipman" &
flock -xn $tmp_directory/11 -c "xfce4-panel" &
flock -xn $tmp_directory/12 -c "nm-applet" &
flock -xn $tmp_directory/13 -c "xiccd" &

if [[ $(lsb_release -is) == "Debian" ]]; then
  flock -xn $tmp_directory/14 -c "/usr/share/xscreensaver/xscreensaver-wrapper.sh -no-splash" &
  # flock -xn $tmp_directory/07 -c "/usr/libexec/gsd-disk-utility-notify" &
fi

if [[ $(lsb_release -is) == "Ubuntu" ]]; then
  flock -xn $tmp_directory/14 -c "/usr/libexec/ayatana-indicator-application/ayatana-indicator-application-service" &
  flock -xn $tmp_directory/15 -c "/usr/lib/x86_64-linux-gnu/indicator-messages/indicator-messages-service" &
  flock -xn $tmp_directory/16 -c "/usr/libexec/geoclue-2.0/demos/agent" &
  flock -xn $tmp_directory/17 -c "/usr/bin/snap userd --autostart" &
  flock -xn $tmp_directory/18 -c "xfce4-screensaver" &
  flock -xn $tmp_directory/19 -c "update-notifier" &
  # Exec=sh -c 'if [ "x$XDG_SESSION_TYPE" = "xwayland" ] ; then exec env IM_CONFIG_CHECK_ENV=1 im-launch true; fi'
  # TryExec=im-launch
fi
