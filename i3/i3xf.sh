#!/usr/bin/env bash

rootApplicationsDirectory="/usr/share/applications"
userApplicationsDirectory="$HOME/.local/share/applications"
xfce4PanelProfilesMirrorLink="http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb"

# When using i3-wm you can not use everything in xfce4-settings-manager so we hide those options
unhandledSettings=(
  "xfce-session-settings.desktop"
  "xfce-backdrop-settings.desktop" 
  "xfce-workspaces-settings.desktop" 
  "xfce-wmtweaks-settings.desktop" 
  "xfce-wm-settings.desktop" 
)

function showConfigurationItems () {
  for item in "${unhandledSettings[@]}"; do
    rm -f $userApplicationsDirectory/$item
  done
}

function hideConfigurationItems () {
  for item in "${unhandledSettings[@]}"; do
    echo "Hidden=true" > $userApplicationsDirectory/$item
  done
}

function installEssentials () {
  # Create symbolic-link for gnome-control-center to let the global-menu work
  sudo ln -sf /bin/xfce4-settings-manager /usr/local/bin/gnome-control-center
  sudo apt install ca-certificates curl wget gzip tar nano ssh git gnupg lsb-release gparted pwgen unzip zip net-tools vim -y
  sudo apt install cups menulibre mugshot catfish lightdm slick-greeter xfce4-appmenu-plugin xfce4-screenshooter gnome-software synaptic stacer -y
  
  if [[ $(uname -n) == "debian" ]]; then
    cd /tmp && wget $xfce4PanelProfilesMirrorLink
    sudo apt install ./xfce4-panel-profiles*.deb
  fi
}

function installAll () {
  echo " "
  hideConfigurationItems
  sudo apt update -qq
  installEssentials
  echo " "
}

function printUsage () {
  echo " "
  echo "USAGE: install | hide_conf_items | show_conf_items"
  echo "--------------------------------------------------"
  echo "$0 install         | Install packages and set everything up for i3-wm"
  echo "$0 show_conf_items | Show all configuration-items in xfce4-settings-manager"
  echo "$0 hide_conf_items | Hide unhandled configuration-items in xfce4-settings-manager"
  echo " "
}

############
case "$1" in

install)
  installAll
  ;;

hide_conf_items)
  hideConfigurationItems
  ;;

show_conf_items)
  showConfigurationItems
  ;;

*)
  printUsage
  ;;

esac
exit