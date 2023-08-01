#!/usr/bin/env bash

# https://design.ubuntu.com/font
# https://github.com/microsoft/cascadia-code/releases
# https://www.mongodb.com/docs/compass/master/install
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux

download_snaps=true

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

# sudo apt install git zsh vim nano zip unzip curl wget -y

apt-get install ssh tar gzip bzip2 bzip3 7zip p7zip-full xzip fastjar lrzip lsb-release ca-certificates software-properties-common gnupg dpkg bat gh -y
apt-get install xfce4 xfce4-goodies catfish mugshot xfce4-panel-profiles slick-greeter lightdm-settings numlockx xinput xdotool wmctrl members neofetch -y
apt-get install cpuid cpuidtool lshw ghostscript v4l-utils fzf jq net-tools fail2ban cmatrix screenkey orca onboard minicom cutecom screen lrzsz pandoc -y
apt-get install ufw gufw gimp vlc pitivi simplescreenrecorder obs-studio libreoffice mousepad thunderbird galculator imagemagick exiftool htop powertop -y
apt-get install arc-theme gnome-icon-theme elementary-xfce-icon-theme gnome-system-monitor gnome-disk-utility remmina openssl libpcre3 synaptic rofi -y
apt-get install ntfs-3g dosfstools exfatprogs dos2unix cifs-utils smbclient samba nfs-common ftp tftp tftpd-hpa mariadb-client gparted stacer baobab -y
apt-get install pwgen perl dbus-x11 libnss3 firefox-esr network-manager network-manager-gnome network-manager-openvpn network-manager-openvpn-gnome -y
apt-get install ffmpeg libsodium23 libsecret-tool libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y

# DEBIAN-PACKAGES FROM THE NON-FREE REPOS (CONTRIB NON-FREE):
apt-add-repository contrib non-free -y
apt-get install ttf-mscorefonts-installer unrar -y

if $download_snaps; then
  apt-get install snapd -y
  snap install spotify
  snap install keepassxc
  ln -s /etc/profile.d/apps-bin-path.sh /etc/X11/Xsession.d/99snap
fi

if [ ! -f "$(command -v google-chrome-stable)" ]; then
  cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt-get install ./google-chrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -d "/usr/share/fonts/truetype/cascadia-code" ]; then
  mkdir -p /tmp/cascadia-code && cd /tmp/cascadia-code || exit
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

echo " "
echo "DISABLING FAIL2BAN FROM AUTO STARTING AT BOOT" && sleep 2
echo " "

systemctl disable fail2ban.service

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

# INSTALL DOCKER FOR DEBIAN-LINUX
# https://docs.docker.com/engine/install/debian

debian_codename=$(lsb_release -cs)

docker_url="https://download.docker.com/linux/debian"
docker_apt="/etc/apt/sources.list.d/docker.list"
docker_gpg="/etc/apt/keyrings/docker.gpg"

install -m 0755 -d /etc/apt/keyrings
curl -fsSL $docker_url/gpg | gpg --dearmor --batch --yes --output $docker_gpg
chmod a+r $docker_gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=$docker_gpg] $docker_url $debian_codename stable" | tee $docker_apt >/dev/null

apt-get update
apt-get install apache2 libapache2-mpm-itk libapache2-mod-php sqlite3 pre-commit -y
apt-get install php php-cli php-common php-xdebug php-mysql php-mbstring php-curl php-soap php-readline -y
apt-get install php-imagick php-gd php-bcmath php-opcache php-xml php-zip php-pear php-phpseclib php-sqlite3 -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Debian Warning: Missing home dir /var/lib/tpm
# Probably a warning displayed when KVM is installed
# This code may fix the warning-message
mkdir -p /var/lib/tpm

# https://christitus.com/vm-setup-in-linux
apt-get install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y

virsh net-start default
virsh net-autostart default

usermod -aG docker "$SUDO_USER"
usermod -aG libvirt-qemu "$SUDO_USER"
usermod -aG libvirt "$SUDO_USER"
usermod -aG input "$SUDO_USER"
usermod -aG disk "$SUDO_USER"
usermod -aG kvm "$SUDO_USER"

usermod -s /bin/zsh "$SUDO_USER"

$download_snaps && snap install insomnia
$download_snaps && snap install dbeaver-ce
$download_snaps && snap install sqlitebrowser
$download_snaps && snap install mysql-workbench-community

if [ ! -f "$(command -v code)" ]; then
  url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  cd /tmp && wget -O vscode_amd64.deb "$url_latest_vscode"
  apt-get install ./vscode_amd64.deb -y
  rm -f vscode_amd64.deb
fi

if [ ! -f "$(command -v mongodb-compass)" ]; then
  cd /tmp && wget $url_mongo_db_compass
  apt-get install ./mongodb-compass*amd64.deb -y
  rm -f mongodb-compass*amd64.deb
fi

if [ ! -f "$(command -v marktext)" ]; then
  cd /tmp && wget $url_marktext_package
  apt-get install ./marktext-amd64.deb -y
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

chmod 755 /etc/grub.d/06_override_theme

update-grub

fc-cache -s

apt upgrade -y
apt autoremove -y

echo " "
echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable apache2.service
systemctl stop apache2.service

cd /usr/local/bin || exit

echo " "
echo "DOWNLOADING UTILITY-SCRIPTS TO /USR/LOCAL/BIN" && sleep 2
echo " "

wget -O phpsrv https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/phpsrv.sh

echo " "
echo "Content in: /usr/local/bin"
echo " "

chmod -Rf 755 /usr/local/bin/*
ls -al /usr/local/bin

echo " "
echo "DONE"
echo " "

# FIX ISSUES WITH THE TIME WHEN DUAL-BOOTING WINDOWS AND LINUX
# ON WINDOWS YOU CAN FIX THIS PROBLEM USING BELOW COMMANDS IN AN ELEVATED CMD-WINDOW
# - net start w32time
# - w32tm /resync
# - net stop w32time
# YOU CAN POSSIBLY SCHEDULE A TASK IN TASKMANAGER TO RUN THOSE COMMANDS AT START OR WHEN YOU LOG IN TO WINDOWS
#
# ON LINUX YOU SHALL BE ABLE TO FIX THIS PROBLEM USING THE BELOW COMMAND (NOT WORKING)
# timedatectl set-local-rtc 1 --adjust-system-clock
#
# SE LINKS FOR MORE SOLUTIONS:
# https://answers.microsoft.com/en-us/windows/forum/all/how-to-force-windows-10-time-to-synch-with-a-time/20f3b546-af38-42fb-a2d0-d4df13cc8f43
# https://askubuntu.com/questions/946516/how-to-tell-ubuntu-that-hardware-clock-is-local-time
# https://www.makeuseof.com/fix-dual-booting-linux-wrong-windows-time
#
# chromium-codecs-ffmpeg-extra // Unable to locate package
#
# apt-get install <package> --dry-run
# apt-get install cpufreqd cpufrequtils acpi cpulimit
# apt-get install make gcc build-essential linux-headers-$(uname-r)
#
# open file /etc/login.defs // Not needed
# add in line ENV_PATH PATH= ?
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
# it should be: ?
# ENV_PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
#
# google-chrome --password-store=basic
#
# Workaround for problems with underscores in vscode
# https://github.com/microsoft/vscode/issues/38133
#
# https://christitus.com/linux-security-mistakes
# ufw limit 22/tcp
# ufw allow 80/tcp
# ufw allow 443/tcp
# ufw allow 8000/tcp
# ufw default deny incoming
# ufw default allow outgoing
# ufw enable
#
# Nala frontend for apt allowing parallel-downloads
#
# sudo apt install nala
# sudo nala fetch (set repositories)
# sudo nala install <package>
# sudo nala upgrade // update + upgrade + autoremove
#
# https://phoenixnap.com/kb/nala-apt
# https://christitus.com/stop-using-apt
# https://trendoceans.com/nala-package-manager
# https://gitlab.com/volian/nala/-/wikis/Installation
