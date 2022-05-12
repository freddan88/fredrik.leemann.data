#!/usr/bin/env bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INSTALLING SOFTWARE" && sleep 2
echo " "
apt update -qq && apt install xorg i3 i3status slim lxappearance arandr pulseaudio alsa-utils pavucontrol debian-edu-artwork gnome-disks gvfs gvfs-backends gvfs-fuse -y

cd /tmp && wget https://github.com/adi1090x/slim_themes/archive/refs/heads/master.zip && unzip -o master.zip
cd /tmp && rm -rf master.zip

echo " "
echo "DONE!"
echo " "