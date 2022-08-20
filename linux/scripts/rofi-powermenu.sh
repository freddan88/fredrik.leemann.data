#!/usr/bin/env bash

option=$(printf "Lock\nLogout\nReboot\nShutdown" | rofi -dmenu -i -theme /usr/share/rofi/themes/Pop-Dark.rasi)

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

case "$option" in
"Lock")
  dm-tool lock
  ;;
"Logout")
  wm=$(wmctrl -m | grep 'Name' | cut -d":" -f2 | xargs)
  if [ "${wm}" = "Openbox" ]; then
    openbox --exit
  elif [ "${wm}" = "i3" ]; then
    i3-msg exit
  else
    pkill x
  fi
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
