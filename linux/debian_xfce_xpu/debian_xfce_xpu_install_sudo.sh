#!/usr/bin/env bash

install_snaps=true
install_docker=true
install_virtualization=true
install_development_software=true

# sudo apt install wget sudo -y
#
# sudo apt install debian-goodies -y
# sudo dpkg-reconfigure popularity-contest
# sudo apt install libreoffice-help-sv mythes-sv hunspell-sv-se hyphen-sv -y
#
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux
# https://www.mongodb.com/docs/compass/master/install
# https://github.com/marktext/marktext/releases

kubernetes_kubectl_version="stable"

url_mongo_db_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.39.0_amd64.deb"
url_marktext_package="https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-amd64.deb"

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

  apt update && apt upgrade -y && apt autoremove -y

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

echo " "
echo "INSTALLING SOFTWARE" && sleep 2
echo " "

# DEBIAN-PACKAGES FROM THE NON-FREE REPOS (CONTRIB NON-FREE):
apt-add-repository contrib non-free -y
apt-get install ttf-mscorefonts-installer unrar -y

apt-get install task-xfce-desktop task-ssh-server xfce4-panel-profiles network-manager-openvpn-gnome slick-greeter catfish mugshot dirmngr dbus-x11 -y
apt-get install gimp vlc pitivi simplescreenrecorder obs-studio galculator gnome-system-monitor gnome-disk-utility stacer baobab dialog rsync inxi -y
apt-get install gstreamer1.0-vaapi libsodium23 v4l-utils ffmpeg libavcodec-extra libsecret-tools gnupg pwgen imagemagick exiftool ghostscript -y
apt-get install trash-cli ranger thefuck tldr rofi tmux tree exa bat ripgrep xdotool wmctrl members fzf zoxide entr mc lshw cpuid cpuidtool -y
apt-get install ntfs-3g dosfstools exfatprogs dos2unix cifs-utils smbclient samba nfs-common ftp tftp tftpd-hpa gparted httpie httping perl -y
apt-get install fail2ban libnss3 pandoc net-tools nmap lrzsz minicom cutecom remmina thunderbird orca onboard screenkey htop powertop curl -y
apt-get install zip unzip tar gzip bzip2 bzip3 7zip p7zip-full xzip fastjar lrzip xinput numlockx aptitude dpkg tasksel synaptic ufw gufw -y
apt-get install arc-theme elementary-xfce-icon-theme ssh openssl zsh git gh nano vim neovim lsb-release neofetch cmatrix screen unclutter -y
# apt-get install ifuse usbmuxd libimobiledevice6 libimobiledevice-utils gvfs-backends gvfs-fuse shotwell -y
# apt-get install ifuse usbmuxd libimobiledevice6 libimobiledevice-utils gvfs-backends gvfs-fuse -y
# https://community.linuxmint.com/software/view/ifuse
# https://wiki.archlinux.org/title/IOS

usermod -s /bin/zsh "$SUDO_USER"

echo " "
echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable tftpd-hpa.service
systemctl stop tftpd-hpa.service

echo " "
echo "DISABLING FAIL2BAN FROM AUTO STARTING AT BOOT" && sleep 2
echo " "

systemctl disable fail2ban.service

echo " "
echo "DISABLING SSH-SERVER FROM AUTO STARTING AT BOOT" && sleep 2
echo " "

systemctl disable ssh.service

echo " "
echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable smbd.service
systemctl disable nmbd.service
systemctl stop smbd.service
systemctl stop nmbd.service

echo " "

if [ "$(systemd-detect-virt)" == 'kvm' ]; then
  apt-get install spice-vdagent
fi

if $install_snaps; then
  apt-get install snapd -y
  snap install spotify
  snap install keepassxc
  ln -s /etc/profile.d/apps-bin-path.sh /etc/X11/Xsession.d/99snap
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

if [ ! -d "/usr/share/fonts/truetype/intel-one-mono" ]; then
  font_name="intel-one-mono"
  font_install_dir="/usr/share/fonts/truetype/$font_name"
  font_url=$(curl -s https://api.github.com/repos/intel/intel-one-mono/releases/latest | grep "browser_download_url" | grep ttf.zip | awk -F '"' '{print $4}')
  cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip "$font_url" && unzip $font_name.zip
  mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
  cd /tmp && rm -rf $font_name
fi

if [ ! "$(command -v code)" ]; then
  url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  cd /tmp && wget -O vscode_amd64.deb "$url_latest_vscode"
  apt-get install ./vscode_amd64.deb -y
  rm -f vscode_amd64.deb
fi

if [ ! "$(command -v google-chrome-stable)" ]; then
  cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt-get install ./google-chrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb

  cd /usr/share/icons || exit
  wget -O google_chrome_incognito.png https://sandstormit.com/wp-content/uploads/2021/06/incognito-2231825_960_720-1.png
fi

if [ ! -f "/opt/firefox/firefox" ]; then
  # Download-page: https://www.mozilla.org/sv-SE/firefox/all/#product-desktop-developer
  # Installation-guide: https://dev.to/harrsh2124/how-to-setup-firefox-developer-edition-on-ubuntu-4inp
  firefox_developer_url="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US&_gl=1*nm7b4v*_ga*MTExMjY4MTY4My4xNjkxMDQ1Nzc0*_ga_MQ7767QQQW*MTY5MTA1MTcwMC4yLjAuMTY5MTA1MTc1Ny4wLjAuMA.."
  cd /opt && wget -O firefox_developer_edition.tar.bz2 "$firefox_developer_url"
  tar xjfv firefox_developer_edition.tar.bz2
  rm -f firefox_developer_edition.tar.bz2

  cd /usr/share/icons || exit
  wget -O firefox_developer_edition_private.png https://sandstormit.com/wp-content/uploads/2021/06/incognito-2231825_960_720-1.png
fi

if [ -f "/sbin/ifconfig" ]; then
  ln -s /sbin/ifconfig /bin/ifconfig
fi

if [ -f "/etc/network/interfaces" ]; then
  cp /etc/network/interfaces /etc/network/interfaces.bak
fi

if [ ! -f "/usr/local/bin/smnetscanner" ]; then
  # Network Scanner For Linux Command Line (smnetscanner)
  # https://www.youtube.com/watch?v=4hjskxkapYo
  # https://cloud.compumatter.biz/s/fxfYM9SkamBtGqG

  cd /usr/local/bin || exit
  wget -O smnetscanner https://cloud.compumatter.biz/s/fxfYM9SkamBtGqG/download/smnetscanner.sh
fi

if [ -d "/srv/tftp" ]; then
  chown -R tftp:nogroup /srv/tftp
fi

if $install_virtualization; then
  # Debian Warning: Missing home dir /var/lib/tpm
  # Probably a warning displayed when KVM is installed
  # This code may fix the warning-message
  mkdir -p /var/lib/tpm

  # https://christitus.com/vm-setup-in-linux
  apt-get install python3 python3-pip virt-manager -y
  apt-get install qemu-kvm qemu-system qemu-utils libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon -y

  echo " "
  echo "HANDLE NETWORKS FOR QEMU-KVM VIRTUAL MACHINES"
  echo " "

  virsh net-start default 2>/dev/null
  virsh net-autostart default 2>/dev/null

  usermod -aG libvirt-qemu "$SUDO_USER"
  usermod -aG libvirt "$SUDO_USER"
  usermod -aG input "$SUDO_USER"
  usermod -aG disk "$SUDO_USER"
  usermod -aG kvm "$SUDO_USER"
fi

cd /
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_root.zip
unzip -o debian_xfce_xpu_root.zip
rm -f debian_xfce_xpu_root.zip

chmod 644 /etc/grub.d/06_override_theme

echo " "
fc-cache -f -v

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

apt-get install apache2 libapache2-mpm-itk libapache2-mod-php sqlite3 mariadb-client jq pre-commit -y
apt-get install php php-cli php-common php-xdebug php-mysql php-mbstring php-curl php-soap php-readline -y
apt-get install php-imagick php-gd php-bcmath php-opcache php-xml php-zip php-pear php-phpseclib php-sqlite3 -y

$install_snaps && snap install insomnia
$install_snaps && snap install dbeaver-ce
$install_snaps && snap install sqlitebrowser
$install_snaps && snap install mysql-workbench-community

cd /usr/share/icons || exit
wget -O sqlitebrowser.svg https://raw.githubusercontent.com/sqlitebrowser/sqlitebrowser/master/images/logo.svg

if [ ! "$(command -v mongodb-compass)" ]; then
  cd /tmp && wget $url_mongo_db_compass
  apt-get install ./mongodb-compass*amd64.deb -y
  rm -f mongodb-compass*amd64.deb
fi

if [ ! "$(command -v marktext)" ]; then
  cd /tmp && wget $url_marktext_package
  apt-get install ./marktext-amd64.deb -y
  rm -f marktext-amd64.deb
fi

if $install_docker; then
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

  apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

  usermod -aG docker "$SUDO_USER"
fi

cd /usr/local/bin || exit

if $install_docker; then
  if [ ! -f "/usr/local/bin/lazydocker" ]; then
    # https://github.com/jesseduffield/lazydocker
    url=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}' | grep 'Linux_x86_64.tar.gz')
    wget -O lazydocker.tar.gz "$url" && tar xzvf lazydocker.tar.gz lazydocker && rm -f lazydocker.tar.gz
  fi
fi

if [ ! -f "/usr/local/bin/kubectl" ]; then
  kubectl_version="$kubernetes_kubectl_version"
  if [ "$kubernetes_kubectl_version" = "stable" ]; then
    kubectl_version="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
  fi
  echo "DOWNLOADING KUBECTL: $kubectl_version (Kubernetes cli-tool)" && sleep 2
  echo " "
  curl -LO "https://dl.k8s.io/release/$kubectl_version/bin/linux/amd64/kubectl"
  chmod -f 755 /usr/local/bin/kubectl
fi

if [ ! -f "/usr/local/bin/phpsrv" ]; then
  wget -O phpsrv https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/phpsrv.sh
fi

if [ ! -f "/usr/local/bin/composer" ]; then
  cd /tmp && wget https://getcomposer.org/installer
  php ./installer --quiet && mv -f composer.phar /usr/local/bin/composer
  chmod -f 755 /usr/local/bin/composer && rm -f installer
  echo "INSTALLED PHP-COMPOSER IN: /usr/local/bin/composer"
fi

echo " "
echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable apache2.service
systemctl stop apache2.service

print_user_global_bin_and_exit_script

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
#
# cd /usr/share/icons
# wget -O google_chrome_incognito_01.png https://sandstormit.com/wp-content/uploads/2021/06/incognito-2231825_960_720-1.png
# wget -O google_chrome_incognito_02.png https://www.iconarchive.com/download/i125711/pictogrammers/material/incognito-circle.512.png
#
# font_name="jetbrains-mono"
# font_install_dir="/usr/share/fonts/truetype/$font_name"
# font_url=$(curl -s https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
# cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip $font_url && unzip $font_name.zip
# mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
# cd /tmp && rm -rf $font_name
#
# font_name="cascadia-code"
# font_install_dir="/usr/share/fonts/truetype/$font_name"
# font_url=$(curl -s https://api.github.com/repos/microsoft/cascadia-code/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
# cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip $font_url && unzip $font_name.zip
# mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
# cd /tmp && rm -rf $font_name
#
# font_name="ubuntu-font-family"
# font_install_dir="/usr/share/fonts/truetype/$font_name"
# font_url=$(curl -s https://api.github.com/repos/canonical/Ubuntu-fonts/releases/latest | grep 'browser_download_url' | awk -F '"' '{print $4}')
# cd /tmp && mkdir $font_name && cd $font_name && wget -O $font_name.zip $font_url && unzip $font_name.zip && cd Ubuntu-fonts-*
# mkdir $font_install_dir && find . -name "*.ttf" -exec install -m644 {} $font_install_dir \;
# cd /tmp && rm -rf $font_name
#
# List installed fonts
# fc-list | grep "cascadia-code"
# fc-list | grep "jetbrains-mono"
# fc-list | grep "ubuntu-font-family"
#
# Install fonts manually on linux
# https://medium.com/source-words/how-to-manually-install-update-and-uninstall-fonts-on-linux-a8d09a3853b0
#
# zip-files from terminal
# zip -r debian_xfce_xpu_home.zip .*
# zip -r debian_xfce_xpu_root.zip .*
