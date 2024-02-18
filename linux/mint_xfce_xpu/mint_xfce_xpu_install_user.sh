#!/usr/bin/env bash

install_latest_node_lts=true
install_vscode_extensions=true

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
echo "INSTALLING SCRIPTS AND CONFIGURATIONS" && sleep 2
echo " "

cd "$HOME" && mkdir -p Apps
cd "$HOME" && mkdir -p .local/bin

# Version manager for node.js
# https://github.com/nvm-sh/nvm
#
if $install_latest_node_lts && [ ! -d "$HOME/.nvm" ]; then
  script_name="nvm-sh"
  script_url=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep 'zipball_url' | awk -F '"' '{print $4}')
  mkdir -p /tmp/$script_name && cd /tmp/$script_name && wget -O $script_name.zip "$script_url" && unzip $script_name.zip && cd nvm-sh-nvm-* || exit
  cd /tmp && rm -rf $script_name
fi

if $install_latest_node_lts; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  echo " "
  echo "INSTALLING LATEST LTS FOR NODE.JS AND NPM"
  echo " "

  nvm install --lts
fi

echo " "

# Oh My Zsh is an open source shell-framework
# https://ohmyz.sh
# https://github.com/paulirish/git-open
# https://github.com/zsh-users/zsh-autosuggestions
#
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/paulirish/git-open.git .oh-my-zsh/custom/plugins/git-open

echo " "

# Replace old configurations for the user and load keybindings + new desktop-layout
# https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/debian_xfce_xpu/debian_xfce_xpu_files/home
#
cd "$HOME" && rm -rf .config/rofi
cd "$HOME" && rm -rf .config/xfce4
cd "$HOME" && rm -rf .config/Code/User/snippets

# wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_home.zip
# unzip -o debian_xfce_xpu_home.zip
# rm -f debian_xfce_xpu_home.zip - TODO: Download

xfce4-panel-profiles load /usr/share/xfce4-panel-profiles/layouts/debian_xfce_xpu_panel_01.tar.bz2

# Install visual studio code (code-editor from microsoft)
# https://code.visualstudio.com/
#
# if $install_vscode_extensions && [ "$(command -v code)" ]; then
#   if [ -f ".config/Code/vscode_extensions_install_user.sh" ]; then
#     echo " "
#     echo "INSTALLING VSCODE EXTENSIONS" && sleep 2
#     echo " "

#     chmod 754 .config/Code/vscode_extensions_install_user.sh
#     .config/Code/vscode_extensions_install_user.sh

#     rm -f .config/Code/vscode_extensions_install_user.sh
#   fi
# fi - TODO: Make sure the script is downloaded

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
