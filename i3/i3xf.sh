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

function showConfigurationItems() {
  for item in "${unhandledSettings[@]}"; do
    rm -f $userApplicationsDirectory/$item
  done
}

function hideConfigurationItems() {
  for item in "${unhandledSettings[@]}"; do
    echo "Hidden=true" >$userApplicationsDirectory/$item
  done
}

# https://gist.github.com/keeferrourke/d29bf364bd292c78cf774a5c37a791db
# sudo apt install fonts-cantarell fonts-cascadia-code ttf-ubuntu-font-family -y
# wget https://github.com/google/fonts/archive/main.tar.gz
# tar -zxvf main.tar.gz
# sudo mkdir -p /usr/share/fonts/truetype/google-fonts
# ls
# ls fonts-main/
# find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/
# find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
# cd ..
# rm -rf fonts/
# fc-cache -f

function installEssentials() {
  # Create symbolic-link for gnome-control-center to let the global-menu work
  sudo ln -sf /bin/xfce4-settings-manager /usr/local/bin/gnome-control-center
  sudo apt install i3 i3status suckless-tools picom rofi playerctl xbacklight numlockx dos2unix xterm ftp tftpd-hpa net-tools fail2ban -y
  sudo apt install ca-certificates zsh curl wget gzip bzip2 unzip zip tar ssh git lshw htop gnupg lsb-release pwgen nano vim ufw gufw -y
  sudo apt install cups system-config-printer colord xiccd xarchiver exo-utils ntfs-3g exfat-utils dosfstools lightdm slick-greeter -y
  sudo apt install menulibre mugshot catfish xfce4-appmenu-plugin xfce4-screenshooter gparted gnome-software synaptic stacer ffmpeg -y
  sudo apt install gimp mirage thunderbird libreoffice ghostscript vlc openssl samba libpcre3 neofetch screenkey cpuid nitrogen -y
  sudo apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme debian-edu-artwork members cifs-utils screen typecatcher -y
  # apt install sqlite3 apache2 libapache2-mod-php php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} -y
  # apt install libapache2-mpm-itk libsodium23 sqlitebrowser docker-ce docker-ce-cli containerd.io imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 -y
  # apt install imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y
  # apt install cutecom minicom

  if [[ $(uname -n) == "debian" ]]; then
    cd /tmp && wget $xfce4PanelProfilesMirrorLink
    sudo apt install ./xfce4-panel-profiles*.deb
  fi
}

function installAll() {
  echo " "
  hideConfigurationItems
  sudo apt update -qq
  installEssentials
  echo " "
}

function printUsage() {
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
