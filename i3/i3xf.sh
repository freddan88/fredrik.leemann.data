#!/usr/bin/env bash

url_zsh_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt"
url_mongodb_compass="https://github.com/mongodb-js/compass/releases/download/v1.30.1/mongodb-compass_1.30.1_amd64.deb"
url_xfce_panel_profiles="http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb"
url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

# https://gist.github.com/keeferrourke/d29bf364bd292c78cf774a5c37a791db
# sudo apt install fonts-cantarell fonts-cascadia-code ttf-ubuntu-font-family -y
# wget $url_google_fonts
# tar -zxvf main.tar.gz
# sudo mkdir -p /usr/share/fonts/truetype/google-fonts
# ls
# ls fonts-main/
# find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/
# find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
# cd ..
# rm -rf fonts/
# fc-cache -f

# When using i3-wm you can not use everything in xfce4-settings-manager so we hide those options
unhandled_settings=(
  "xfce-session-settings.desktop"
  "xfce-backdrop-settings.desktop"
  "xfce-workspaces-settings.desktop"
  "xfce-wmtweaks-settings.desktop"
  "xfce-wm-settings.desktop"
)

user_applications_directory="$HOME/.local/share/applications"

function show_configuration_items() {
  echo " "
  echo "SHOWING XFCE-SPECIFIC CONFIGURATION ITEMS" && sleep 2
  for item in "${unhandled_settings[@]}"; do
    rm -f $user_applications_directory/$item
  done
  echo " "
}

function hide_configuration_items() {
  echo " "
  echo "HIDING XFCE-SPECIFIC CONFIGURATION ITEMS" && sleep 2
  for item in "${unhandled_settings[@]}"; do
    echo "Hidden=true" >$user_applications_directory/$item
  done
  echo " "
}

function check_sudo_user() {
  if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
    echo " "
    echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
    echo " "
    exit
  fi
}

function setup_initialization() {
  url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
  url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
  echo " "
  echo "INITIALIZE" && sleep 2
  apt update -qq && apt install lsb-release gnupg ca-certificates curl wget git gzip bzip2 unzip zip tar -y
  # Create symbolic-link for gnome-control-center to let the global-menu work
  ln -sf /bin/xfce4-settings-manager /usr/local/bin/gnome-control-center
  # Download and add linux-penguin wallpaper from wallpapersafari.com
  mkdir -p /usr/share/wallpapers
  wget -q $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg
  echo " "
  echo "INSTALLING FONTS" && sleep 2
  cd /tmp && wget -q $url_jetbrains_mono_fonts && unzip -qqo JetBrainsMono*.zip
  cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
  cd /tmp && find $PWD/fonts/ttf/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono/ \;
  cd /tmp && wget -q $url_google_fonts && tar -zxvf main.tar.gz
  cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
  cd /tmp && find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
  cd /tmp && rm -rf fonts* JetBrainsMono*.zip main.tar.gz && fc-cache
}

function install_essential_software() {
  url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  echo " "
  echo "INSTALLING ESSENTIAL SOFTWARE" && sleep 2
  echo " "
  apt install i3 i3status suckless-tools picom rofi playerctl xbacklight numlockx xterm samba cifs-utils screen members -y
  apt install zsh ssh ftp tftp htop pwgen net-tools fail2ban dos2unix nano vim ntfs-3g exfat-utils dosfstools exo-utils vlc -y
  apt install colord xiccd xarchiver ufw gufw tftpd-hpa menulibre mugshot ffmpeg cutecom minicom cups system-config-printer -y
  apt install lightdm slick-greeter catfish xfce4-appmenu-plugin xfce4-screenshooter gparted gnome-software synaptic stacer -y
  apt install gimp mirage thunderbird libreoffice xscreensaver gnome-disks gnome-system-monitor gnome-power-statistics gnome-calendar -y
  apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme debian-edu-artwork typecatcher nitrogen baobab -y
  apt install ghostscript openssl libpcre3 neofetch screenkey cpuid cpuidtool cpuinfo lshw -y

  ln -s /sbin/ifconfig /usr/bin/ifconfigs
  chown -R tftp:nogroup /srv/tftp 2>/dev/null
  cd /tmp && wget -q $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb

  if [[ $(uname -n) == "debian" ]]; then
    cd /tmp && wget $url_xfce_panel_profiles
    apt install ./xfce4-panel-profiles*.deb
  fi

  echo " "
  echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable smbd.service
  systemctl disable nmbd.service
  systemctl stop smbd.service
  systemctl stop nmbd.service

  echo " "
  echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable tftpd-hpa.service
  systemctl stop tftpd-hpa.service
}

function install_developer_software() {
  url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  echo " "
  echo "INSTALLING WEB-DEVELOPER SOFTWARE"
  echo " "
  # apt install apache2 libapache2-mpm-itk libapache2-mod-php libsodium23 sqlite3 sqlitebrowser mysql-client -y
  # apt install php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} -y
  # apt install imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 -y
  # apt install libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y
  # apt install docker-ce docker-ce-cli containerd.io -y

  cd /tmp && wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb && apt install ./dbeaver-ce_*_amd64.deb -y
  cd /tmp && wget -q -O vscode_amd64.deb $url_latest_vscode && apt install ./vscode_amd64.deb -y
  cd /tmp && wget -q $url_mongodb_compass && apt install ./mongodb-compass_*_amd64.deb -y
  rm -f dbeaver-ce_*_amd64.deb vscode_amd64.deb mongodb-compass_*_amd64.deb

  usermod -aG docker $SUDO_USER

  echo " "
  echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable apache2.service
  systemctl stop apache2.service
}

function install_all() {
  # check_sudo_user
  # setup_initialization
  # install_essential_software
  echo -n "Install tools for web-developing? (y/N): "
  read answear
  if [[ "${answear}" == "y" ]]; then install_developer_software; fi
}

function print_usage() {
  echo " "
  echo "USAGE: install | show-xfce-conf-items | hide-xfce-conf-items"
  echo "--------------------------------------------------"
  echo "$0 install              | Install packages and set everything up for i3-wm"
  echo "$0 show-xfce-conf-items | Show xfce specific configuration-items in xfce4-settings-manager"
  echo "$0 hide-xfce-conf-items | Hide xfce specific configuration-items in xfce4-settings-manager"
  echo " "
}

############
case "$1" in

install)
  install_all
  ;;

show-xfce-conf-items)
  show_configuration_items
  ;;

hide-xfce-conf-items)
  hide_configuration_items
  ;;

*)
  print_usage
  ;;

esac
exit
