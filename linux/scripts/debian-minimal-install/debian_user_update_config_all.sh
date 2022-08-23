#!/usr/bin/env bash

url_gtk3_theme_config="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/themes/gtk3-settings.ini"
url_nitrogen_config_wallpaper="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/wallpapers/debian-nitrogen-bg-saved.cfg"
url_xfce4_configurations="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/configurations/xfce4.zip"
url_home_templates="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip"
url_utility_script_power_menu="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/rofi-power-menu.sh"
url_utility_script_system_menu="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/rofi-system-menu.sh"
url_utility_script_keyboard="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/minimal-keyboard-configuration.sh"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$SUDO_USER" ]; then
  echo " "
  echo "PLEASE DO NOT RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

mkdir -p "$HOME"/.config/nitrogen && cd "$HOME"/.config/nitrogen || exit
wget -O bg-saved.cfg $url_nitrogen_config_wallpaper

echo " "
pwd && ls -al "$HOME"/.config/nitrogen

echo " "
echo "DOWNLOADING AND ADDING TEMPLATES FOR THE FILEBROWSER" && sleep 2
echo " "

/usr/bin/xdg-user-dirs-update
xdg-mime default thunar.desktop inode/directory

cd "$HOME" || exit
dir_home_templates=$(xdg-user-dir TEMPLATES)

cd "$dir_home_templates" && rm -f ./*
cd "$dir_home_templates" && wget $url_home_templates
cd "$dir_home_templates" && unzip -o templates.zip
cd "$dir_home_templates" && rm -f templates.zip

echo " "
pwd && ls -al "$dir_home_templates"

echo " "
echo "DOWNLOADING AND INSTALLING CONFIGURATION FOR GTK-THEME" && sleep 2
echo " "

mkdir -p "$HOME"/.config/gtk-3.0
cd "$HOME"/.config/gtk-3.0 || exit
wget -O settings.ini $url_gtk3_theme_config

echo " "
pwd && ls -al "$HOME"/.config/gtk-3.0

echo " "
echo "DOWNLOADING AND INSTALLING CONFIGURATION FOR XFCE4" && sleep 2
echo " "

cd "$HOME"/.config && rm -rf xfce4
cd "$HOME"/.config && wget $url_xfce4_configurations
cd "$HOME"/.config && unzip -o xfce4.zip
cd "$HOME"/.config && rm -f xfce4.zip

echo " "
pwd && ls -al "$HOME"/.config/xfce4

echo " "
echo "DOWNLOADING LOCAL UTILITY-SCRIPTS" && sleep 2
echo " "

mkdir -p "$HOME"/.local/bin && cd "$HOME"/.local/bin || exit
wget -O minimal-keyboard-configuration $url_utility_script_keyboard
wget -O rofi-system-menu $url_utility_script_system_menu
wget -O rofi-power-menu $url_utility_script_power_menu
chmod -R 754 "$HOME"/.local/bin

echo " "
pwd && ls -al "$HOME"/.local/bin

echo " "
echo "DONE!"
echo " "
