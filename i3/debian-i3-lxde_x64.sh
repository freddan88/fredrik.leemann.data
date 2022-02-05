#!/bin/sh

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

DEBIAN_REMOTE_I3_SCRIPT_NAME="debian-i3-main_x64.sh"
DEBIAN_XRANDR_RESTORE_SCRIPT="xrandr-restore.sh"

if [ ! -f "$DEBIAN_REMOTE_I3_SCRIPT_NAME" ]; then
  wget -q https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/$DEBIAN_REMOTE_I3_SCRIPT_NAME
fi

if [ ! -f ".$DEBIAN_XRANDR_RESTORE_SCRIPT" ]; then
  wget -q https://github.com/freddan88/fredrik.linux.files/blob/main/shell/$DEBIAN_XRANDR_RESTORE_SCRIPT
  mv -f $DEBIAN_XRANDR_RESTORE_SCRIPT .$DEBIAN_XRANDR_RESTORE_SCRIPT
  chown $SUDO_USER:$SUDO_USER .$DEBIAN_XRANDR_RESTORE_SCRIPT
  chmod -f 754 .xrandr-restore.sh
fi

chmod -f 754 $DEBIAN_REMOTE_I3_SCRIPT_NAME && chown -f $SUDO_USER:$SUDO_USER $DEBIAN_REMOTE_I3_SCRIPT_NAME

install_all() {
  ./$DEBIAN_REMOTE_I3_SCRIPT_NAME install

  apt update -qq
  apt install picom xorg network-manager network-manager-gnome lxpanel lxterminal lxappearance lxrandr pcmanfm xscreensaver notification-daemon policykit-1 featherpad -y
  apt install pulseaudio pulseaudio-utils pavucontrol lxde-icon-theme -y
  # gnome-screenshot screenkey screenruler

  echo " "
  echo "DONE"
  echo " "
}

print_usage() {
  echo " "
  echo "USAGE: install"
  echo "$0 install | Install everything and get the latest configurations"
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
