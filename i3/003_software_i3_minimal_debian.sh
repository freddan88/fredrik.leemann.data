#!/usr/bin/env bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS COMMAND AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INSTALLING SOFTWARE" && sleep 2
apt update -qq && apt install xorg i3 i3status slim lxappearance arandr pulseaudio alsa-utils pavucontrol debian-edu-artwork gnome-disks gvfs gvfs-backends gvfs-fuse -y

echo " "
echo "DONE!"
echo " "
