#!/usr/bin/env bash

url_xfce_panel_profiles="http://ftp.ports.debian.org/debian-ports/pool/main/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-1.1_all.deb"

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
