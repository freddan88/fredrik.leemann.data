#!/usr/bin/env bash

url_zsh_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/home/.zshrc"
url_i3_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/home/.config/i3/config_i3xf.txt"
url_i3status_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/home/.config/i3/config_i3status"
url_xfce_panel_profiles="http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb"
url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"
url_mongodb_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

# When using i3-wm you can not use everything in xfce4-settings-manager so we hide those options
unhandled_settings=(
  "xfce-session-settings.desktop"
  "xfce-backdrop-settings.desktop"
  "xfce-workspaces-settings.desktop"
  "xfce-wmtweaks-settings.desktop"
  "xfce-wm-settings.desktop"
)

user_applications_directory="$HOME/.local/share/applications"

function check_sudo_user() {
  if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
    echo " "
    echo "PLEASE RUN THIS COMMAND AS A SUDO-USER"
    echo " "
    exit
  fi
}

function check_no_sudo_user() {
  if [ -n "$SUDO_USER" ]; then
    echo " "
    echo "PLEASE DO NOT RUN THIS COMMAND AS A SUDO-USER"
    echo " "
    exit
  fi
}

update_zsh_config() {
  check_no_sudo_user
  echo " "
  echo "UPDATING ZSH CONFIG" && sleep 2
  cd $HOME && rm -f $HOME/.zshrc
  wget -q -O .zshrc $url_zsh_config && chmod -f 664 $HOME/.zshrc
  echo " "
}

function update_i3_config() {
  check_no_sudo_user
  echo " "
  echo "UPDATING i3 CONFIG" && sleep 2
  rm -rf $HOME/.config/i3 && mkdir -p $HOME/.config/i3 && cd $HOME/.config/i3
  wget -q $url_i3status_config && wget -q -O config $url_i3_config
  echo " "
}

function show_configuration_items() {
  check_no_sudo_user
  echo " "
  echo "SHOWING XFCE-SPECIFIC CONFIGURATION ITEMS" && sleep 2
  for item in "${unhandled_settings[@]}"; do
    rm -f $user_applications_directory/$item
  done
  echo " "
}

function hide_configuration_items() {
  check_no_sudo_user
  echo " "
  echo "HIDING XFCE-SPECIFIC CONFIGURATION ITEMS" && sleep 2
  for item in "${unhandled_settings[@]}"; do
    echo "Hidden=true" >$user_applications_directory/$item
  done
  echo " "
}

update_php_composer() {
  check_sudo_user
  echo " "
  echo "UPDATING PHP COMPOSER" && sleep 2
  cd /tmp && rm -f /usr/local/bin/composer
  cd /tmp && wget -q https://getcomposer.org/installer && php ./installer >/dev/null
  cd /tmp && mv -f composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer
  cd /tmp && rm -f installer
  echo " "
}

update_docker_compose() {
  latest_docker_compose=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
  latest_docker_compose_version=$(echo $latest_docker_compose | cut -d'/' -f8)
  check_sudo_user
  echo " "
  echo "UPDATING DOCKER COMPOSE" && sleep 2
  cd /tmp && rm -f /usr/local/bin/docker-compose
  cd /tmp && wget -q https://github.com/docker/compose/releases/download/$latest_docker_compose_version/docker-compose-Linux-x86_64
  cd /tmp && mv -f docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod -f 755 /usr/local/bin/docker-compose
  echo " "
}

update_postman_app() {
  check_sudo_user
  echo " "
  echo "UPDATING POSTMAN APP" && sleep 2
  cd /tmp && rm -R -f /opt/Postman && rm -f /usr/local/bin/postman
  cd /tmp && wget -q -O postman-x64.tar.gz https://dl.pstmn.io/download/latest/linux64 && tar -xf postman-x64.tar.gz
  cd /tmp && mv -f Postman /opt && ln -s /opt/Postman/app/postman /usr/local/bin/postman && chmod -f 775 /opt/Postman/app/postman
  cd /tmp && rm -f postman-x64.tar.gz
  echo " "
}

function setup_initialization() {
  url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
  url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
  echo " "
  echo "INITIALIZE" && sleep 2
  echo " "
  apt update -qq && apt install lsb-release gnupg ca-certificates curl wget git gzip bzip2 unzip zip tar -y

  # Create symbolic-link for gnome-control-center to let the global-menu work
  ln -sf /bin/xfce4-settings-manager /usr/local/bin/gnome-control-center

  # Download and add linux-penguin wallpaper from wallpapersafari.com
  cd /tmp && mkdir -p /usr/share/wallpapers
  cd /tmp && wget -q $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg

  echo "INSTALLING FONTS" && sleep 2
  apt install fonts-cascadia-code fonts-cantarell -y
  cd /tmp && wget -q $url_jetbrains_mono_fonts && unzip -qqo JetBrainsMono*.zip
  cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
  cd /tmp && find $PWD/fonts/ttf/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono/ \;
  cd /tmp && wget -q $url_google_fonts && tar -zxvf main.tar.gz
  cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
  cd /tmp && find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
  cd /tmp && rm -rf fonts* JetBrainsMono*.zip main.tar.gz && fc-cache -f
}

function install_essential_software() {
  url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  echo " "
  echo "INSTALLING ESSENTIAL SOFTWARE" && sleep 2
  echo " "
  apt install i3 i3status nitrogen picom rofi playerctl xbacklight numlockx xterm screen members onboard spice-vdagent -y
  apt install zsh ssh ftp tftp htop pwgen net-tools fail2ban dos2unix nano vim ntfs-3g exfat-utils dosfstools exo-utils blueman -y
  apt install colord xiccd xarchiver ufw gufw tftpd-hpa menulibre mugshot ffmpeg cutecom minicom cups system-config-printer -y
  apt install lightdm slick-greeter catfish xfce4-appmenu-plugin xfce4-screenshooter gparted gnome-software synaptic stacer -y
  apt install gimp mirage thunderbird libreoffice gnome-system-monitor gnome-calendar thunar-archive-plugin typecatcher vlc -y
  apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme baobab cmatrix samba cifs-utils nfs-common util-linux -y
  apt install ghostscript openssl libpcre3 neofetch screenkey cpuid cpuidtool cpuinfo lshw pandoc lightdm-settings gthumb -y

  apt install flatpak gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  flatpak install flathub com.spotify.Client --noninteractive -y

  chown -R tftp:nogroup /srv/tftp 2>/dev/null
  cd /tmp && wget -q $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
  cd /tmp && rm -f google-chrome-stable_current_amd64.deb

  if [[ $(lsb_release -is) == "Debian" ]]; then
    ln -s /sbin/ifconfig /usr/bin/ifconfigs
    apt install xscreensaver gnome-disks debian-edu-artwork
    cd /tmp && wget $url_xfce_panel_profiles && apt install ./xfce4-panel-profiles*.deb
    cd /tmp && rm -f xfce4-panel-profiles*.deb
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

  if [[ $(lsb_release -is) == "Debian" ]]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
  fi

  if [[ $(lsb_release -is) == "Ubuntu" ]]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
  fi

  apt update -qq && apt install docker-ce docker-ce-cli containerd.io -y
  apt install apache2 libapache2-mpm-itk libapache2-mod-php libsodium23 sqlite3 sqlitebrowser mysql-client -y
  apt install php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} -y
  apt install imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 -y
  apt install libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y

  flatpak install flathub rest.insomnia.Insomnia --noninteractive -y
  flatpak install flathub com.github.alecaddd.sequeler --noninteractive -y

  cd /tmp && wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb && apt install ./dbeaver-ce_*_amd64.deb -y
  cd /tmp && wget -q -O vscode_amd64.deb $url_latest_vscode && apt install ./vscode_amd64.deb -y
  cd /tmp && wget -q $url_mongodb_compass && apt install ./mongodb-compass_*_amd64.deb -y
  cd /tmp && rm -f dbeaver-ce_*_amd64.deb vscode_amd64.deb mongodb-compass_*_amd64.deb

  echo " "
  echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable apache2.service
  systemctl stop apache2.service

  usermod -aG docker $SUDO_USER

  update_postman_app
  update_php_composer
  update_docker_compose
}

function install_all() {
  check_sudo_user
  setup_initialization
  install_essential_software
  echo -n "Install tools for web-developing? (y/N) [Default = N]: "
  read answear
  if [[ "${answear}" == "y" ]]; then install_developer_software; fi
}

function print_usage() {
  echo " "
  echo "USAGE:"
  echo "$0 install-all            | (sudo) Install packages and more for i3-wm"
  echo "$0 install-dev            | (sudo) Only install web-developer software"
  echo "$0 update-postman-app     | (sudo) Update to the latest postman api-testing software"
  echo "$0 update-php-composer    | (sudo) Update to the latest php-composer package-manager"
  echo "$0 update-docker-compose  | (sudo) Update to the latest docker-compose file from @github"
  echo "$0 update-zsh-config      | (user) Update configuration for zsh-shell from freddan88@github"
  echo "$0 update-i3-config       | (user) Update configurations for i3 and i3status from freddan88@github"
  echo "$0 show-xfce-conf-items   | (user) Show xfce specific configuration-items in xfce4-settings-manager"
  echo "$0 hide-xfce-conf-items   | (user) Hide xfce specific configuration-items in xfce4-settings-manager"
  echo " "
}

############
case "$1" in

install-all)
  install_all
  ;;

install-dev)
  install_developer_software
  ;;

update-postman-app)
  update_postman_app
  ;;

update-php-composer)
  update_php_composer
  ;;

update-docker-compose)
  update_docker_compose
  ;;

update-zsh-config)
  update_zsh_config
  ;;

update-i3-config)
  update_i3_config
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
