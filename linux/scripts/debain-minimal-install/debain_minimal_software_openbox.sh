#!/usr/bin/env bash

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
echo "INSTALLING i3 SOFTWARE" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

apt install openbox obconf -y
