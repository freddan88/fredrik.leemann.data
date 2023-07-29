#!/usr/bin/env bash

# https://design.ubuntu.com/font
# https://github.com/microsoft/cascadia-code/releases
# https://www.mongodb.com/docs/compass/master/install
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux

download_snaps=false

kubernetes_kubectl_version="stable"

url_mongo_db_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.39.0_amd64.deb"
url_marktext_package="https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-amd64.deb"
url_fonts_cascadia_code="https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
url_fonts_ubuntu="https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INSTALLING SOFTWARE" && sleep 2
echo " "

# sudo apt install curl wget zip unzip nano vim -y

# Debian-packages from the non-free repos (contrib non-free):
apt-add-repository contrib non-free -y
apt install ttf-mscorefonts-installer unrar -y
apt update && apt upgrade -y

apt install ssh git zsh tar gzip bzip2 bzip3 7zip p7zip-full xzip fastjar lrzip lsb-release ca-certificates software-properties-common gnupg dpkg bat -y
apt install xfce4 xfce4-goodies catfish mugshot xfce4-panel-profiles slick-greeter lightdm-settings numlockx xinput xdotool wmctrl members neofetch gh -y
apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme gnome-system-monitor gnome-disk-utility remmina openssl libpcre3 synaptic nala rofi -y
apt install ntfs-3g dosfstools exfatprogs dos2unix cifs-utils smbclient samba nfs-common ftp tftp tftpd-hpa mariadb-client gparted stacer perl baobab -y
apt install cpuid cpuidtool lshw ghostscript v4l-utils fzf jq net-tools fail2ban cmatrix screenkey orca onboard minicom cutecom screen lrzsz pandoc -y
apt install ufw gufw gimp vlc pitivi simplescreenrecorder obs-studio libreoffice mousepad thunderbird galculator imagemagick exiftool htop powertop -y
apt install pwgen libsodium23 network-manager network-manager-gnome network-manager-openvpn network-manager-openvpn-gnome -y
apt install ffmpeg libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y

if [ $download_snaps ]; then
  apt install snapd -y
  snap install spotify
  snap install keepassxc
  ln -s /etc/profile.d/apps-bin-path.sh /etc/X11/Xsession.d/99snap
fi

if [ ! -f "$(command -v google-chrome-stable)" ]; then
  cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt install ./google-chfredrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -d "/usr/share/fonts/truetype/cascadia-code" ]; then
  mkdir /tmp/cascadia-code && cd /tmp/cascadia-code || exit
  wget $url_fonts_cascadia_code && unzip CascadiaCode-*.zip
  mkdir -p /usr/share/fonts/truetype/cascadia-code && cd /tmp/cascadia-code/ttf || exit
  find . -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/cascadia-code \;
  rm -rf cascadia-code
fi

if [ ! -d "/usr/share/fonts/truetype/ubuntu-font-family" ]; then
  cd /tmp && wget $url_fonts_ubuntu -O ubuntu-font-family.zip && unzip ubuntu-font-family.zip
  mkdir -p /usr/share/fonts/truetype/ubuntu-font-family && cd /tmp/ubuntu-font-family-* || exit
  find . -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/ubuntu-font-family \;
  rm -rf __MACOSX ubuntu-font-family*
fi

echo "DISABLING SSH-SERVER FROM AUTO STARTING AT BOOT" && sleep 2
echo " "

systemctl disable ssh.service

echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable smbd.service
systemctl disable nmbd.service
systemctl stop smbd.service
systemctl stop nmbd.service

echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable tftpd-hpa.service
systemctl stop tftpd-hpa.service

if [ -d "/srv/tftp" ]; then
  chown -R tftp:nogroup /srv/tftp 2>/dev/null
fi

debian_codename=$(lsb_release -cs)
docker_url="https://download.docker.com/linux/debian"
docker_gpg="/etc/apt/keyrings/docker.gpg"

install -m 0755 -d /etc/apt/keyrings
curl -fsSL $docker_url/gpg | sudo gpg --dearmor -o $docker_gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=$docker_gpg] $docker_url $debian_codename stable" | sudo tee text.txt >/dev/null

apt update
apt install apache2 libapache2-mpm-itk libapache2-mod-php sqlite3 -y
apt install php php-cli php-common php-xdebug php-mysql php-mbstring php-curl php-soap php-readline -y
apt install php-imagick php-gd php-bcmath php-opcache php-xml php-zip php-pear php-phpseclib php-sqlite3 -y
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

usermod -aG docker "$SUDO_USER"

$download_snaps && snap install insomnia
$download_snaps && snap install dbeaver-ce
$download_snaps && snap install sqlitebrowser
$download_snaps && snap install mysql-workbench-community

if [ ! -f "$(command -v code)" ]; then
  url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  cd /tmp && wget -O vscode_amd64.deb "$url_latest_vscode"
  apt install ./vscode_amd64.deb -y
  rm -f vscode_amd64.deb
fi

if [ ! -f "$(command -v mongodb-compass)" ]; then
  cd /tmp && wget $url_mongo_db_compass
  apt install ./mongodb-compass*amd64.deb -y
  rm -f mongodb-compass*amd64.deb
fi

if [ ! -f "$(command -v marktext)" ]; then
  cd /tmp && wget $url_marktext_package
  apt install ./marktext-amd64.deb -y
  rm -f marktext-amd64.deb
fi

if [ ! -d "/usr/local/bin/composer" ]; then
  cd /tmp && wget https://getcomposer.org/installer
  php ./installer && mv -f composer.phar /usr/local/bin/composer
  chmod -f 755 /usr/local/bin/composer && rm -f installer
fi

if [ ! -d "/usr/local/bin/kubectl" ]; then
  kubectl_version="$kubernetes_kubectl_version"
  if [ "$kubernetes_kubectl_version" = "stable" ]; then
    kubectl_version="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
  fi
  cd /usr/local/bin || exit
  echo "DOWNLOADING KUBECTL: $kubectl_version (Kubernetes cli-tool)" && sleep 2
  echo " "
  curl -LO "https://dl.k8s.io/release/$kubectl_version/bin/linux/amd64/kubectl"
  chmod -f 755 /usr/local/bin/kubectl
fi

if [ -f "/sbin/ifconfig" ]; then
  ln -s /sbin/ifconfig /bin/ifconfig
fi

if [ -f "/etc/network/interfaces" ]; then
  cp /etc/network/interfaces /etc/network/interfaces.bak
fi

cd /
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_root.zip
unzip -oq debian_xfce_xpu_root.zip
rm -f debian_xfce_xpu_root.zip

grub-update && echo " "
fc-cache -s && echo " "
apt update && apt upgrade -y && apt autoremove -y

echo " "
echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable apache2.service
systemctl stop apache2.service

echo " "
echo "DONE"
echo " "

# chromium-codecs-ffmpeg-extra // Unable to locate package
#
# apt install <package> --dry-run
# apt install cpufreqd cpufrequtils acpi cpulimit
# apt install make gcc build-essential linux-headers-$(uname-r)
#
# open file /etc/login.defs // Not needed
# add in line ENV_PATH PATH= ?
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
# it should be: ?
# ENV_PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
#
# google-chrome --password-store=basic
