#!/bin/bash

URL_I3_CONFIG="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config-i3-minimal.txt"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

DEBIAN_REMOTE_I3_SCRIPT_NAME="debian-i3_x64.sh"

if [ ! -f "/tmp/debian-i3-xfce_x64" ]; then
  cd /tmp && wget -q https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/$DEBIAN_REMOTE_I3_SCRIPT_NAME
fi

chmod 754 /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME

install_all() {
  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME install
  echo " "

  apt update -qq
  apt install lxpanel lxterminal lxappearance lxrandr pcmanfm xscreensaver xbacklight numlockx notification-daemon xorg i3 i3status rofi stacer gimp mirage -y
  apt install picom git zsh curl tar bzip2 zip unzip nano ffmpeg lshw htop ssh vlc nitrogen gnome-icon-theme lxde-icon-theme debian-edu-artwork featherpad ffmpeg -y
  apt install ufw gufw network-manager network-manager-gnome fail2ban synaptic neofetch unclutter pulseaudio pulseaudio-utils pavucontrol suckless-tools playerctl -y
  apt install apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php -y
  apt install imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 sqlitebrowser -y
  apt install libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra thunderbird libreoffice libpcre3 libsodium23 ghostscript -y
  apt install libapache2-mpm-itk openssl sqlite3 policykit-1 docker-ce docker-ce-cli containerd.io -y
  # gnome-screenshot screenkey screenruler

  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME i3-config
  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME php-composer
  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME docker-compose
  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME postman-app
  echo " "
}

get_zsh_config() {
  /tmp/$DEBIAN_REMOTE_I3_SCRIPT_NAME i3-config
  echo " "
}

print_usage() {
  echo " "
  echo "USAGE: install | i3-config"
  echo "$0 install | Install everything and get the latest configurations"
  echo "$0 zsh-config | Download the latest zsh-configuration from GitHub"
  echo " "
}

############
case "$1" in

install)
  install_all
  print_usage
  ;;

zsh-config)
  get_zsh_config
  print_usage
  ;;

*)
  print_usage
  ;;

esac
exit
