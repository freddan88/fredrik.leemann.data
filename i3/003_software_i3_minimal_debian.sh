#!/usr/bin/env bash

# Link to file on GitHub
# https://github.com/freddan88/fredrik.linux.files/blob/main/i3/003_software_i3_minimal_debian.sh

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
apt install xorg xinput slim lxappearance arandr pulseaudio alsa-utils pavucontrol gvfs gvfs-backends gvfs-fuse libnotify-bin -y

apt autoremove -y && apt update

if [ ! -d "/usr/share/slim/themes/cayny" ]; then
  cd /tmp && wget https://github.com/adi1090x/slim_themes/archive/refs/heads/master.zip && unzip -o master.zip
  cd /tmp/slim_themes-master/themes && cp -rfv * /usr/share/slim/themes
  cd /tmp && rm -rf master.zip slim_themes-master
  cd /tmp && wget https://github.com/freddan88/fredrik.linux.files/raw/main/i3/downloads/background.png
  cd /usr/share/slim/themes/cayny && mv background.png background_old_01.png
  cd /tmp && mv background.png /usr/share/slim/themes/cayny/background.png
fi

slimConfString=$(cat /etc/slim.conf | grep "current_theme")
slimConfArray=($slimConfString)
# read -a slimConfArray <<<"$slimConfString"
sed -i "s/${slimConfArray[1]}/cayny/g" /etc/slim.conf

# sudo update-rc.d slim disable

echo " "
echo "DONE!"
echo " "
