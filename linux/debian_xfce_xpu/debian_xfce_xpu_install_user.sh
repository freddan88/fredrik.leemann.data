#!/usr/bin/env bash

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

wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_home.zip
unzip -oq debian_xfce_xpu_home.zip
rm -f debian_xfce_xpu_home.zip
