#!/usr/bin/env sh

option=$(printf "Logout\nReboot\nShutdown" | rofi -dmenu -i -theme /usr/share/rofi/themes/Pop-Dark.rasi)

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

case "$option" in
"Logout")
  # openbox --exit
  # systemctl restart display-manager
  pkill x
  ;;
"Reboot")
  systemctl reboot
  ;;
"Shutdown")
  systemctl poweroff
  ;;
*)
  exit 1
  ;;
esac
