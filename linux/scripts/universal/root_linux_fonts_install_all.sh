#!/usr/bin/env bash

url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
url_cascadia_code="https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
# url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"
# url_jetbrains_mono_fonts_nerd="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"

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

apt install fonts-cascadia-code fonts-cantarell -y

# if [ ! -d "/usr/share/fonts/truetype/jetbrains-mono" ]; then
#   cd /tmp && wget $url_jetbrains_mono_fonts && unzip -o JetBrainsMono*.zip
#   cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
#   cd /tmp && find $PWD/fonts/ttf -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono \;
#   cd /tmp && rm -rf JetBrainsMono*.zip fonts
# fi

if [ ! -d "/usr/share/fonts/truetype/google-fonts" ]; then
  # https://github.com/google/fonts
  cd /tmp && wget $url_google_fonts && tar -zxvf main.tar.gz
  cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
  cd /tmp && find "$PWD"/fonts-main -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts \;
  cd /tmp && rm -rf main.tar.gz fonts-main
fi

if [ ! -d "/usr/share/fonts/truetype/cascadia-code" ]; then
  # https://github.com/microsoft/cascadia-code
  cd /tmp && wget $url_cascadia_code && unzip CascadiaCode-2111.01.zip
  cd /tmp && mkdir -p /usr/share/fonts/truetype/cascadia-code
  cd /tmp && find "$PWD"/CascadiaCode*/ttf -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/cascadia-code \;
  cd /tmp && rm -rf CascadiaCode*
fi

# if [ ! -d "/usr/share/fonts/truetype/jetbrains-mono-nerd" ]; then
#   cd /tmp && mkdir -p jetbrains-mono-nerd && mkdir -p /usr/share/fonts/truetype/jetbrains-mono-nerd
#   cd /tmp/jetbrains-mono-nerd && wget $url_jetbrains_mono_fonts_nerd && unzip -o JetBrainsMono*.zip
#   cd /tmp && find $PWD/jetbrains-mono-nerd -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono-nerd \;
#   cd /tmp && rm -rf JetBrainsMono*.zip jetbrains-mono-nerd
# fi

fc-cache -s && apt autoremove -y

echo " "
echo "DONE!"
echo " "
