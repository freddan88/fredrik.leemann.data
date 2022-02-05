#!/bin/bash

URL_I3_CONFIG="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config-i3-xfce.txt"

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

echo $URL_I3_CONFIG >debian-i3.conf

if [ ! -f "$DEBIAN_REMOTE_I3_SCRIPT_NAME" ]; then
  wget -q https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/$DEBIAN_REMOTE_I3_SCRIPT_NAME
fi

chmod -f 754 $DEBIAN_REMOTE_I3_SCRIPT_NAME && chown -f $SUDO_USER:$SUDO_USER $DEBIAN_REMOTE_I3_SCRIPT_NAME

install_all() {
  ./$DEBIAN_REMOTE_I3_SCRIPT_NAME install

  apt update -qq
  apt install xfce4-screenshooter xfce4-appmenu-plugin arc-theme elementary-xfce-icon-theme compton catfish lightdm slick-greeter -y
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
