#!/usr/bin/env bash

# Link to file on GitHub
# https://github.com/freddan88/fredrik.linux.files/blob/main/i3/005_software_webdev_shared_deb_linux.sh

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
echo "INSTALLING SOFTWARE" && sleep 2
echo " "
