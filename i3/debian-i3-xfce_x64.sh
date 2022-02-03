#!/bin/bash

URL_I3_CONFIG="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config-i3-xfce.txt"

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
  apt install i3 i3status xfce4-screenshooter xfce4-appmenu-plugin arc-theme elementary-xfce-icon-theme gnome-icon-theme debian-edu-artwork thunderbird synaptic mirage -y
  apt install gimp vlc libreoffice compton nitrogen unclutter catfish ssh git zsh curl tar bzip2 zip unzip nano ffmpeg lshw htop openssl ghostscript ufw gufw fail2ban -y
  apt install apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php -y
  apt install neofetch suckless-tools playerctl xbacklight numlockx rofi sqlite3 sqlitebrowser lightdm slick-greeter libreoffice libpcre3 libsodium23 imagemagick -y
  apt install imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libapache2-mpm-itk -y
  apt install libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra stacer -y
  apt install docker-ce docker-ce-cli containerd.io -y
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
