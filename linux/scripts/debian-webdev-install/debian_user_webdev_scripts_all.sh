#!/usr/bin/env bash

url_utility_script_phpsrv="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/phpsrv.sh"

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
echo "DOWNLOADING LOCAL UTILITY-SCRIPTS" && sleep 2
echo " "

mkdir -p "$HOME"/.local/bin && cd "$HOME"/.local/bin || exit
wget -O phpsrv $url_utility_script_phpsrv
chmod -R 754 "$HOME"/.local/bin

echo " "
ls -al "$HOME"/.local/bin

echo " "
echo "DONE!"
echo " "
