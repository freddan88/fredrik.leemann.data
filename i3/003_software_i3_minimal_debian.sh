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
apt update -qq && apt install xorg xinput i3 i3status slim lxappearance arandr pulseaudio alsa-utils pavucontrol debian-edu-artwork gnome-disks gvfs gvfs-backends gvfs-fuse -y

apt autoremove -y && apt update

cd /tmp && wget https://github.com/freddan88/slim_themes/archive/refs/heads/master.zip && unzip -o master.zip
cd /tmp/slim_themes-master/themes && cp -rfv * /usr/share/slim/themes
cd /tmp && rm -rf master.zip slim_themes-master

slimConfString=$(cat /etc/slim.conf | grep "current_theme")
slimConfArray=($slimConfString)
sed -i "s/${slimConfArray[1]}/cayny/g" /etc/slim.conf

echo " "
echo "DONE!"
echo " "
