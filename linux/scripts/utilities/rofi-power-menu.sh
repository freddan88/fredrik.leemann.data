#!/usr/bin/env bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

exit_option="Exit"
lock_option="Lock"
logout_option="Logout"
reboot_option="Reboot"
shutdown_option="Shutdown"

print_usage() {
  echo " "
  echo "Usage:"
  echo " - Running this script with no arguments will show a menu (Requires rofi to be installed)"
  echo " - Arguments: $lock_option | $logout_option | $reboot_option | $shutdown_option"
  echo " - Example: $0 $lock_option"
  echo " "
}

if [[ -n "$1" ]]; then
  case "$1" in
  "$lock_option")
    option="$lock_option"
    ;;
  "$logout_option")
    option="$logout_option"
    ;;
  "$reboot_option")
    option="$reboot_option"
    ;;
  "$shutdown_option")
    option="$shutdown_option"
    ;;
  esac
else
  option=$(
    printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s" \
      "System Power Menu" \
      "-----------------" \
      "$lock_option" \
      "$logout_option" \
      "$reboot_option" \
      "$shutdown_option" \
      " " \
      "$exit_option" | rofi -dmenu
  )
fi

case "$option" in
"$exit_option")
  print_usage
  ;;
"$lock_option")
  dm-tool lock
  ;;
"$logout_option")
  wm=$(wmctrl -m | grep 'Name' | cut -d":" -f2 | xargs)
  if [ "$wm" = "Openbox" ]; then
    openbox --exit
  elif [ "$wm" = "i3" ]; then
    i3-msg exit
  else
    pkill x
  fi
  ;;
"$reboot_option")
  systemctl reboot
  ;;
"$shutdown_option")
  systemctl poweroff
  ;;
*)
  print_usage
  ;;
esac
