#!/usr/bin/env bash

url_i3_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config_i3_minimal.txt"
url_i3_status_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config_i3_status.txt"

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
apt update -qq && apt install xorg i3 i3status slim lxappearance arandr pulseaudio alsa-utils pavucontrol debian-edu-artwork gvfs gvfs-backends gvfs-fuse -y

echo " "
echo "DONE!"
