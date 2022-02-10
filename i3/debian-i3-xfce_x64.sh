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

echo $URL_I3_CONFIG >'debian-i3-config_url.txt'

install_all() {
  echo " "
  apt update -qq
  apt install catfish lightdm slick-greeter xfce4-screenshooter xfce4-appmenu-plugin -y

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
