#!/usr/bin/env bash

url_config_i3="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/i3/i3-minimal-config.txt"
url_config_i3_status="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/i3/i3-status-config.txt"
url_config_i3_xfce4_panel="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/configurations/i3/i3-xfce4-panel.tar.bz2"
url_styles_i3_keybindings="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3/i3keybindings.css"
url_script_i3_keybindings="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3/i3keybindings.sh"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$SUDO_USER" ]; then
  echo " "
  echo "PLEASE DO NOT RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

# apt install i3 i3status -y

echo " "
echo "UPDATING i3 CONFIGS" && sleep 2
echo " "

rm -rf $HOME/.config/i3 && mkdir -p $HOME/.config/i3 && cd $HOME/.config/i3
wget -O config $url_config_i3 && wget -O config_i3status $url_config_i3_status

mkdir -p $HOME/.config/i3/scripts && cd $HOME/.config/i3/scripts
wget $url_script_i3_keybindings
chmod u+x i3keybindings.sh

mkdir -p $HOME/.config/i3/docs && cd $HOME/.config/i3/docs
wget $url_styles_i3_keybindings

echo " "
echo "NEW i3 CONFIG-FILES IN $HOME/.config/i3" && sleep 2
echo " "

ls -al $HOME/.config/i3

cd $HOME/.local/share/xfce4-panel-profiles
rm -f i3-xfce4-panel-01.tar.bz2
wget $url_config_i3_xfce4_panel

# i3-msg restart 1>/dev/null
# i3-msg reload 1>/dev/null

echo " "
echo "DONE!"
echo " "
