#!/bin/bash

URL_I3_CONFIG="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config-i3-lxde.txt"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

if [ -f "/var/lock/debian-i3.lock" ]; then
  echo " "
  echo "THE SCRIPT HAS ALREADY RUN"
  echo " "
  exit
fi

echo $URL_I3_CONFIG >'debian-i3-config_url.txt'

DEBIAN_XRANDR_RESTORE_SCRIPT="xrandr-restore.sh"

if [ ! -f ".$DEBIAN_XRANDR_RESTORE_SCRIPT" ]; then
  wget -q https://github.com/freddan88/fredrik.linux.files/blob/main/shell/$DEBIAN_XRANDR_RESTORE_SCRIPT
  mv -f $DEBIAN_XRANDR_RESTORE_SCRIPT .$DEBIAN_XRANDR_RESTORE_SCRIPT
  chown $SUDO_USER:$SUDO_USER .$DEBIAN_XRANDR_RESTORE_SCRIPT
  chmod -f 754 .xrandr-restore.sh
fi

install_all() {
  echo " "
  apt update -qq
  apt install xorg network-manager network-manager-gnome lxpanel lxterminal lxappearance lxrandr pcmanfm xscreensaver notification-daemon policykit-1 lxpolkit -y
  apt install pulseaudio pulseaudio-utils pavucontrol lxde-icon-theme featherpad cups system-config-printer colord xiccd xarchiver exo-utils -y
  apt install xfce4-screenshooter xfce4-appfinder xfce4-power-manager xfce4-notifyd --no-install-recommends -y

  rm -f /usr/share/applications/pcmanfm-desktop-pref.desktop
  rm -f /usr/share/applications/vim.desktop

  echo " "
  echo "DONE"
  echo " "
}

print_usage() {
  echo " "
  echo "USAGE: install"
  echo "$0 install | Install packages using apt in this script"
  echo " "
}

############
case "$1" in

install)
  install_all
  ;;

*)
  print_usage
  ;;

esac
exit
