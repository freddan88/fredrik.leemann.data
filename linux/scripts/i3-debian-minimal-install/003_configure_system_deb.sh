#!/usr/bin/env bash

url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
url_latest_slim_themes="https://github.com/adi1090x/slim_themes/archive/refs/heads/master.zip"
url_slim_custom_background="https://github.com/freddan88/fredrik.linux.files/raw/main/i3/downloads/slim_cayny_background_01.png"

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
echo "CONFIGURING SYSTEM" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release slim -y

if [ ! -f "/usr/share/wallpapers/linux-wallpaper-01.jpg" ]; then
  cd /tmp && mkdir -p /usr/share/wallpapers
  cd /tmp && wget $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg
fi

if [ ! -d "/usr/share/slim/themes/cayny" ]; then
  cd /tmp && wget $url_latest_slim_themes && unzip -o master.zip
  cd /tmp/slim_themes-master/themes && cp -rfv * /usr/share/slim/themes
  cd /tmp && rm -rf master.zip slim_themes-master
  cd /tmp && wget $url_slim_custom_background
  cd /usr/share/slim/themes/cayny && mv background.png background_old_01.png
  cd /tmp && mv slim_cayny_background_01.png /usr/share/slim/themes/cayny/background.png
fi

slimConfString=$(cat /etc/slim.conf | grep "current_theme")
# slimConfArray=($slimConfString)
# read -a slimConfArray <<<"$slimConfString"
slimConfTheme=$(echo $slimConfString | cut -d' ' -f2)
sed -i "s/$slimConfTheme/cayny/g" /etc/slim.conf

# Disabling the graphical login
# sudo update-rc.d slim disable

apt autoremove -y && apt update

echo " "
echo "DONE!"
echo " "
