#!/usr/bin/env bash

install_docker=true
install_virtualization=true
install_development_software=true

# Kubernetes kubectl-version for linux
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
#
kubernetes_kubectl_version="stable"

# MongoDB Compass (GUI) Versions:
# https://www.mongodb.com/try/download/compass
#
url_mongo_db_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.42.1_amd64.deb"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

function print_user_global_bin_and_exit_script() {
  echo " "

  apt-get update && apt-get upgrade -y && apt-get autoremove -y

  echo " "
  echo "Content in: /usr/local/bin"
  echo " "

  chown -R root:root /usr/local/bin
  chmod -Rf 755 /usr/local/bin/*
  ls -al /usr/local/bin

  echo " "
  echo "DONE"
  echo " "

  exit
}

mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
chmod 600 -R "$HOME/.gnupg"
chown -R "$(whoami)" "$HOME/.gnupg"

apt-get update && apt-get install zsh git gh nano vim neovim ssh zip unzip tar gzip bzip2 7zip p7zip-full xzip fastjar lrzip -y
apt-get install neofetch trash-cli ranger thefuck tldr rofi tmux tree exa bat ripgrep xdotool wmctrl members fzf zoxide entr mc lshw -y
apt-get install dos2unix cifs-utils smbclient samba nfs-common ftp tftp tftpd-hpa gparted httpie httping perl curl htop powertop nmap -y
apt-get install spotify-client network-manager-openvpn-gnome catfish mugshot dbus-x11 gimp vlc pitivi simplescreenrecorder obs-studio -y
apt-get install gnome-system-monitor gnome-disk-utility stacer baobab rsync libsodium23 ffmpeg pwgen imagemagick exiftool ghostscript -y
apt-get install pandoc lrzsz minicom cutecom remmina thunderbird orca onboard screenkey xinput numlockx synaptic ufw gufw openssl -y
apt-get install arc-theme elementary-xfce-icon-theme cmatrix screen lsb-release -y

usermod -s /bin/zsh "$SUDO_USER"

echo " "
echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable smbd.service
systemctl disable nmbd.service
systemctl stop smbd.service
systemctl stop nmbd.service

echo " "
echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable tftpd-hpa.service
systemctl stop tftpd-hpa.service
echo " "

if [ -d "/srv/tftp" ]; then
  chown -R tftp:nogroup /srv/tftp
fi

if [ "$(systemd-detect-virt)" == 'kvm' ]; then
  apt-get install spice-vdagent
fi

if $install_virtualization && [ "$(command -v grep -E 'svm|vmx' /proc/cpuinfo)" ]; then
  # Debian Warning: Missing home dir /var/lib/tpm
  # Probably a warning displayed when KVM is installed
  # This code may fix the warning-message
  mkdir -p /var/lib/tpm

  # https://christitus.com/vm-setup-in-linux
  apt-get install python3 python3-pip virt-manager -y
  apt-get install qemu-kvm qemu-system qemu-utils libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon -y

  echo " "
  echo "HANDLE NETWORKS FOR QEMU-KVM VIRTUAL MACHINES"

  virsh net-start default 2>/dev/null
  virsh net-autostart default 2>/dev/null

  usermod -aG libvirt-qemu "$SUDO_USER"
  usermod -aG libvirt "$SUDO_USER"
  usermod -aG input "$SUDO_USER"
  usermod -aG disk "$SUDO_USER"
  usermod -aG kvm "$SUDO_USER"
fi

if $install_docker; then
  # Install docker here
  # https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
  #
  apt-get update && apt-get install ca-certificates curl -y && install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  distro_name=$(cat /etc/os-release | grep -w NAME | cut -d"=" -f2)
  if [ "$distro_name" = '"Linux Mint"' ]; then
    codename=$(cat /etc/os-release | grep -w UBUNTU_CODENAME | cut -d"=" -f2)
    docker_source="deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $codename stable"
    echo "$docker_source" | tee /etc/apt/sources.list.d/docker.list >/dev/null
  else
    echo ""
    echo "Name: INSTALL DOCKER FOR UBUNTU"
    echo ""
  fi

  apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

  usermod -aG docker "$SUDO_USER"
fi

# Install marktext (opensource markdown editor)
# https://github.com/marktext/marktext/releases
# https://github.com/marktext/marktext
#
if [ ! "$(command -v marktext)" ]; then
  base_url="https://api.github.com/repos/marktext/marktext/releases/latest"
  latest_package=$(curl -s $base_url | grep 'browser_download_url' | awk -F '"' '{print $4}' | grep 'amd64.deb')
  wget -O marktext-amd64.deb "$latest_package" && apt-get install ./marktext-amd64.deb -y
  rm -f marktext-amd64.deb
fi

if [ ! -d "/usr/share/fonts/truetype/ubuntu-font-family" ]; then
  # https://design.ubuntu.com/font
  font_name="ubuntu-font-family"
  font_install_dir="/usr/share/fonts/truetype/$font_name"
  font_url=$(curl -s https://api.github.com/repos/canonical/Ubuntu-fonts/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
  cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip $font_url && unzip $font_name.zip && cd Ubuntu-fonts-* || exit
  mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
  cd /tmp && rm -rf $font_name
fi

if [ ! -d "/usr/share/fonts/truetype/cascadia-code" ]; then
  # https://github.com/microsoft/cascadia-code/releases
  font_name="cascadia-code"
  font_install_dir="/usr/share/fonts/truetype/$font_name"
  font_url=$(curl -s https://api.github.com/repos/microsoft/cascadia-code/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
  # font_url="https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
  cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip "$font_url" && unzip $font_name.zip
  mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
  cd /tmp && rm -rf $font_name
fi

if [ ! -d "/usr/share/fonts/truetype/jetbrains-mono" ]; then
  font_name="jetbrains-mono"
  font_install_dir="/usr/share/fonts/truetype/$font_name"
  font_url=$(curl -s https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
  cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip "$font_url" && unzip $font_name.zip
  mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
  cd /tmp && rm -rf $font_name
fi

if [ ! "$(command -v google-chrome-stable)" ]; then
  cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt-get install ./google-chrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -f "/usr/local/bin/smnetscanner" ]; then
  # Network Scanner For Linux Command Line (smnetscanner)
  # https://www.youtube.com/watch?v=4hjskxkapYo
  # https://cloud.compumatter.biz/s/fxfYM9SkamBtGqG

  cd /usr/local/bin || exit
  wget -O smnetscanner https://cloud.compumatter.biz/s/fxfYM9SkamBtGqG/download/smnetscanner.sh
fi

if $install_development_software; then
  echo " "
  echo "NOW INSTALLING SOFTWARE FOR WEB-DEVELOPMENT"
  echo " "
else
  print_user_global_bin_and_exit_script
fi

#########################################################################################
# TO INSTALL WEB-DEVELOPER SOFTWARE: 'install_development_software' MUST BE SET TO TRUE #
#########################################################################################

cd /tmp || exit

apt-get install apache2 libapache2-mpm-itk libapache2-mod-php sqlite3 mariadb-client jq pre-commit -y
apt-get install php php-cli php-common php-xdebug php-mysql php-mbstring php-curl php-soap php-readline -y
apt-get install php-imagick php-gd php-bcmath php-opcache php-xml php-zip php-pear php-phpseclib php-sqlite3 -y

# Install visual studio code (code-editor from microsoft)
#
if [ ! "$(command -v code)" ]; then
  cd /tmp && wget -O vscode_amd64.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  apt-get update && apt-get install ./vscode_amd64.deb -y
  rm -f vscode_amd64.deb
fi

# Install beekeeper studio comunity edition (Database management client)
# https://github.com/beekeeper-studio/beekeeper-studio
#
if [ ! "$(command -v beekeeper-studio)" ]; then
  base_url="https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest"
  latest_package=$(curl -s $base_url | grep 'browser_download_url' | awk -F '"' '{print $4}' | grep 'amd64.deb')
  wget -O beekeeper-studio_amd64.deb "$latest_package"
  apt-get update && apt-get install ./beekeeper-studio_amd64.deb -y
  rm -f beekeeper-studio_amd64.deb
fi

# Install bruno opensource API client
# https://www.usebruno.com/
#
if [ ! "$(command -v bruno)" ]; then
  mkdir -p /etc/apt/keyrings
  gpg --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266
  echo "deb [signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list
  apt-get update && apt-get install bruno
fi

# Install mongodb-compass client to manage mongo-databases
# https://www.mongodb.com/docs/compass/master/install
# https://www.mongodb.com/products/tools/compass
#
if [ ! "$(command -v mongodb-compass)" ]; then
  wget -O mongodb-compass_amd64.deb "$url_mongo_db_compass"
  apt-get update && apt-get install ./mongodb-compass_amd64.deb -y
  rm -f mongodb-compass_amd64.deb
fi

########################################################################
# INSTALLING WEB-DEVELOPER SCRIPTS AND EXECUTABLES TO: /usr/local/bin/ #
########################################################################

cd /usr/local/bin || exit

if [ ! -f "/usr/local/bin/kubectl" ]; then
  kubectl_version="$kubernetes_kubectl_version"
  if [ "$kubernetes_kubectl_version" = "stable" ]; then
    kubectl_version="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
  fi
  echo "DOWNLOADING KUBECTL: $kubectl_version (Kubernetes cli-tool)"
  echo " "
  curl -LO "https://dl.k8s.io/release/$kubectl_version/bin/linux/amd64/kubectl"
fi

if [ ! -f "/usr/local/bin/composer" ]; then
  wget https://getcomposer.org/installer
  php ./installer --quiet && mv -f composer.phar composer
  rm -f installer
fi

if [ ! -f "/usr/local/bin/phpsrv" ]; then
  wget -O phpsrv https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/phpsrv.sh
fi

print_user_global_bin_and_exit_script

# TODO: Add to readme
#
# sudo apt install libreoffice-help-sv mythes-sv hunspell-sv-se hyphen-sv -y

# TODO: Add to zshrc
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# distro_name=$(cat /etc/os-release | grep -w NAME | cut -d"=" -f2)
# if [ "$distro_name" = '"Linux Mint"' ]; then
#   codename=$(cat /etc/os-release | grep -w UBUNTU_CODENAME | cut -d"=" -f2)
#   mint_version=$(cat /etc/os-release | grep -w VERSION | cut -d"=" -f2 | sed 's/\"//g')
#   echo ""
#   echo "Distribution: Linux Mint $mint_version"
#   echo "Ubuntu Codename: $codename"
#   echo ""
# else
#   pretty_name=$(cat /etc/os-release | grep -w PRETTY_NAME | cut -d"=" -f2 | sed 's/\"//g')
#   echo ""
#   echo "Distribution: $pretty_name"
#   echo ""
# fi
