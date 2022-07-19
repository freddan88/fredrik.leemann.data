#!/usr/bin/env bash

url_config_i3="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/i3/i3_minimal_configuration.txt"
url_config_i3_status="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/i3/i3_status_configuration.txt"
url_styles_i3_keybindings="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3/i3keybindings.css"
url_script_i3_keybindings="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3/i3keybindings.sh"
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

echo " "
echo "UPDATING i3 CONFIG" && sleep 2
echo " "

rm -rf $HOME/.config/i3 && mkdir -p $HOME/.config/i3 && cd $HOME/.config/i3
wget -O config $url_config_i3 && wget -O config_i3_status $url_config_i3_status

mkdir -p $HOME/.config/i3/scripts && cd $HOME/.config/i3/scripts
wget $url_script_i3_keybindings
chmod u+x i3keybindings.sh

mkdir -p $HOME/.config/i3/docs && cd $HOME/.config/i3/docs
wget $url_styles_i3_keybindings

echo " "
echo "NEW i3 CONFIG-FILES IN $HOME/.config/i3" && sleep 2
echo " "

ls -al $HOME/.config/i3

# i3-msg restart 1>/dev/null
# i3-msg reload 1>/dev/null

echo " "
echo "DOWNLOADING AND INSTALLING TEMPLATES FOR THE FILEBROWSER"
echo " "

dir_home_templates=$(xdg-user-dir TEMPLATES)

cd "$dir_home_templates" && wget "$url_home_templates"
cd "$dir_home_templates" && unzip -o templates.zip
cd "$dir_home_templates" && rm -f templates.zip

echo " "

ls -al "$dir_home_templates"

echo " "
echo "DONE!"
echo " "
