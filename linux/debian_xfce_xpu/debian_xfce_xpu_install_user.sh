#!/usr/bin/env bash

# Version manager for node.js
# https://github.com/nvm-sh/nvm

install_vscode_extensions=true

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

/usr/bin/xdg-user-dirs-update
xdg-mime default thunar.desktop inode/directory

cd "$HOME" || exit

mkdir -p Apps
mkdir -p .local/bin

wget -qO- $url_latest_nvm | bash

# https://ohmyz.sh
# https://github.com/paulirish/git-open
# https://github.com/zsh-users/zsh-autosuggestions

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/paulirish/git-open.git .oh-my-zsh/custom/plugins/git-open

wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_home.zip
unzip -oq debian_xfce_xpu_home.zip
rm -f debian_xfce_xpu_home.zip

if $install_vscode_extensions; then
  if [ -f ".config/Code/vscode_extensions_install_user.sh" ]; then
    echo " "
    echo "INSTALLING VSCODE EXTENSIONS" && sleep 2
    echo " "

    chmod 754 .config/Code/vscode_extensions_install_user.sh
    .config/Code/vscode_extensions_install_user.sh
  fi
fi

rm -f .config/Code/vscode_extensions_install_user.sh

nvm install --lts

echo " "
echo "ADDING TEMPLATES FOR CONTEXT-MENU" && sleep 2
echo " "

dir_home_templates=$(xdg-user-dir TEMPLATES)

cd "$dir_home_templates" && rm -f ./*
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip
unzip -o templates.zip
rm -f templates.zip

pactl set-sink-volume @DEFAULT_SINK@ 100% 2>/dev/null
pactl set-sink-mute @DEFAULT_SINK@ false 2>/dev/null

rm -rf .config/google-chrome

echo " "
echo "DONE"
echo " "
