#!/usr/bin/env bash

# Version manager for node.js
# https://github.com/nvm-sh/nvm

url_latest_nvm=https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$SUDO_USER" ]; then
  echo " "
  echo "PLEASE DO NOT RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INSTALLING CONFIGURATIONS" && sleep 2
echo " "

cd "$HOME" || exit

mkdir Apps
mkdir .local/bin

wget -qO- $url_latest_nvm | bash

wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_home.zip
unzip -oq debian_xfce_xpu_home.zip
rm -f debian_xfce_xpu_home.zip

if [ -f ".config/Code/vscode_extensions_install_user.sh" ]; then
  echo " "
  echo "INSTALLING VSCODE EXTENSIONS" && sleep 2
  echo " "

  chmod 754 .config/Code/vscode_extensions_install_user.sh
  .config/Code/vscode_extensions_install_user.sh
fi

echo " "
echo "ADDING TEMPLATES FOR CONTEXT-MENU" && sleep 2
echo " "

dir_home_templates=$(xdg-user-dir TEMPLATES)

cd "$dir_home_templates" && rm -f ./*
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip
unzip -o templates.zip
rm -f templates.zip

echo " "
echo "DONE"
echo " "
