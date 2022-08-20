#!/usr/bin/env bash

url_config_openbox="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/openbox/rc.xml"
url_config_openbox_xfce4_panel="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/configurations/openbox/openbox-xfce4-panel-01.tar.bz2"
url_autostart_script_openbox="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/openbox/autostart.sh"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$SUDO_USER" ]; then
  echo " "
  echo "PLEASE DO NOT RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

# apt install openbox obconf -y

echo " "
echo "UPDATING OPENBOX CONFIGS" && sleep 2
echo " "

echo " "
echo "DONE!"
echo " "
