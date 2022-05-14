#!/usr/bin/env bash

url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"

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
echo "INSTALLING FONTS" && sleep 2
echo " "

apt update -qq && apt install fonts-cascadia-code fonts-cantarell fonts-font-awesome -y

if [ ! -d "/usr/share/fonts/truetype/jetbrains-mono" ]; then
  cd /tmp && wget $url_jetbrains_mono_fonts && unzip -o JetBrainsMono*.zip
  cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
  cd /tmp && find $PWD/fonts/ttf/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono/ \;
fi

if [ ! -d "/usr/share/fonts/truetype/google-fonts" ]; then
  cd /tmp && wget $url_google_fonts && tar -zxvf main.tar.gz
  cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
  cd /tmp && find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
fi

cd /tmp && rm -rf fonts* JetBrainsMono*.zip main.tar.gz

echo " "
echo "UPDATING FONT-CACHE" && sleep 2
echo " "
fc-cache -sv

echo " "
echo "DONE!"
echo " "
