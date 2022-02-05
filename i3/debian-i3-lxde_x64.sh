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

echo $URL_I3_CONFIG >'debain_i3_config_url.txt'

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
  apt install picom xorg network-manager network-manager-gnome lxpanel lxterminal lxappearance lxrandr pcmanfm xscreensaver notification-daemon policykit-1 featherpad -y
  apt install pulseaudio pulseaudio-utils pavucontrol lxde-icon-theme -y
  # gnome-screenshot screenkey screenruler

  echo " "
  cd $SUDO_USER_HOME/.config/i3 && wget -q https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/i3status.conf

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
