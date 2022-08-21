#!/usr/bin/env bash

url_nitrogen_config_wallpaper="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/wallpapers/debian-nitrogen-bg-saved.cfg"
url_xfce4_configurations="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/configurations/xfce4.zip"
url_home_templates="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$SUDO_USER" ]; then
  echo " "
  echo "PLEASE DO NOT RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

mkdir -p $HOME/.config/nitrogen && cd $HOME/.config/nitrogen
wget -O bg-saved.cfg $url_nitrogen_config_wallpaper

echo " "
echo "DOWNLOADING AND ADDING TEMPLATES FOR THE FILEBROWSER" && sleep 2
echo " "

/usr/bin/xdg-user-dirs-update
xdg-mime default thunar.desktop inode/directory

cd $HOME
dir_home_templates=$(xdg-user-dir TEMPLATES)

cd $dir_home_templates && rm -f *
cd $dir_home_templates && wget $url_home_templates
cd $dir_home_templates && unzip -o templates.zip
cd $dir_home_templates && rm -f templates.zip

echo " "
pwd && ls -al $dir_home_templates

echo " "
echo "DOWNLOADING AND INSTALLING CONFIGURATION FOR XFCE4" && sleep 2
echo " "

cd $HOME/.config && rm -rf xfce4
cd $HOME/.config && wget $url_xfce4_configurations
cd $HOME/.config && unzip -o xfce4.zip
cd $HOME/.config && rm -f xfce4.zip

echo " "
ls -al $HOME/.config/xfce4

echo " "
echo "DONE!"
echo " "
