#!/usr/bin/env bash

url_latest_slim_themes="https://github.com/adi1090x/slim_themes/archive/refs/heads/master.zip"
url_slim_theme_cayny_background="https://github.com/freddan88/fredrik.linux.files/raw/main/i3/downloads/background.png"

# Link to file on GitHub
# https://github.com/freddan88/fredrik.linux.files/blob/main/i3/003_software_i3_max_debian.sh

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INSTALLING SOFTWARE" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y
# apt install xorg xinput lxappearance arandr pulseaudio alsa-utils pavucontrol libnotify-bin -y

apt install cups system-config-printer

apt autoremove -y && apt update

echo " "
echo "DONE!"
echo " "
