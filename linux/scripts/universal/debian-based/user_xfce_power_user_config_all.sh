#!/usr/bin/env bash

url_home_templates="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip"
url_utility_script_keyboard="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/minimal-keyboard-configuration.sh"

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
echo "CONFIGURING" && sleep 2
echo " "
