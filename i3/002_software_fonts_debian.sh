#!/usr/bin/env bash

url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"

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
echo "INSTALLING FONTS" && sleep 2
apt update -qq && apt install fonts-cascadia-code fonts-cantarell -y
cd /tmp && wget -q $url_jetbrains_mono_fonts && unzip -qqo JetBrainsMono*.zip
cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
cd /tmp && find $PWD/fonts/ttf/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono/ \;
cd /tmp && wget -q $url_google_fonts && tar -zxvf main.tar.gz
cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
cd /tmp && find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
cd /tmp && rm -rf fonts* JetBrainsMono*.zip main.tar.gz && fc-cache -sv

echo " "
echo "DONE!"
