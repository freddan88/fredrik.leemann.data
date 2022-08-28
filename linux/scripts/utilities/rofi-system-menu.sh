#!/usr/bin/env bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

app_theme="Change Theme"
app_wallpaper="Change Wallpaper"
app_sound="Configure Sound"
app_displays="Configure Displays"
app_firewall="Configure Firewall"
app_login="Configure Login Manager"
app_networking_cli="Configure Networking (CLI)"
app_keyboard_cli="Configure Keyboard-Layout (CLI)"
app_software="Configure Software Sources"

option=$(
  printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s" \
    "System Configuration Menu" \
    "-------------------------" \
    "$app_theme" \
    "$app_wallpaper" \
    " " \
    "$app_sound" \
    "$app_displays" \
    "$app_firewall" \
    "$app_login" \
    "$app_software" \
    " " \
    "$app_networking_cli" \
    "$app_keyboard_cli" \
    " " \
    "Exit" | rofi -dmenu
)

case "$option" in
"$app_wallpaper")
  nitrogen
  ;;
"$app_theme")
  lxappearance
  ;;
"$app_sound")
  pavucontrol
  ;;
"$app_displays")
  arandr
  ;;
"$app_networking_cli")
  xterm -fa 'Monospace' -fs 12 -e nmtui
  ;;
"$app_keyboard_cli")
  xterm -fa 'Monospace' -fs 12 -e "$HOME"/.local/bin/minimal-keyboard-configuration
  ;;
"$app_firewall")
  gufw
  ;;
"$app_software")
  software-properties-gtk
  ;;
"$app_login")
  pkexec lightdm-settings
  ;;
*)
  echo " "
  exit 0
  ;;
esac
