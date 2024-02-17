#!/usr/bin/env bash

install_docker=true
install_virtualization=false
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

# sudo apt install libreoffice-help-sv mythes-sv hunspell-sv-se hyphen-sv -y

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
  echo " "

  virsh net-start default 2>/dev/null
  virsh net-autostart default 2>/dev/null

  usermod -aG libvirt-qemu "$SUDO_USER"
  usermod -aG libvirt "$SUDO_USER"
  usermod -aG input "$SUDO_USER"
  usermod -aG disk "$SUDO_USER"
  usermod -aG kvm "$SUDO_USER"
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
mkdir /root/.gnupg
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
chown -R root ~/.gnupg

apt-get install apache2 libapache2-mpm-itk libapache2-mod-php sqlite3 mariadb-client jq pre-commit -y
apt-get install php php-cli php-common php-xdebug php-mysql php-mbstring php-curl php-soap php-readline -y
apt-get install php-imagick php-gd php-bcmath php-opcache php-xml php-zip php-pear php-phpseclib php-sqlite3 -y

# Install docker here
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

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

# Install beekeeper studio comunity edition (Database management client)
# https://github.com/beekeeper-studio/beekeeper-studio
#
if [ ! "$(command -v beekeeper-studio)" ]; then
  base_url="https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest"
  latest_package=$(curl -s $base_url | grep 'browser_download_url' | awk -F '"' '{print $4}' | grep 'amd64.deb')
  wget -O beekeeper-studio_amd64.deb "$latest_package" && apt-get install ./beekeeper-studio_amd64.deb -y
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
  apt-get install ./mongodb-compass_amd64.deb -y
  rm -f mongodb-compass_amd64.deb
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

if [ ! -f "/usr/local/bin/composer" ]; then
  wget https://getcomposer.org/installer
  php ./installer --quiet && mv -f composer.phar /usr/local/bin/composer
  rm -f installer && echo "INSTALLED PHP-COMPOSER IN: /usr/local/bin/composer"
fi

if [ ! -f "/usr/local/bin/phpsrv" ]; then
  wget -O phpsrv https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/utilities/phpsrv.sh
fi

# TODO: Add to z-shell
#
# ubuntu_codename=$(cat /etc/os-release | grep UBUNTU_CODENAME)
# if [[ -n "${ubuntu_codename}" ]]; then
#   codename=$(echo "$ubuntu_codename" | cut -d"=" -f2) // Also needed for docker-installation
#   echo ""
#   echo "UBUNTU CODENAME: $codename"
#   echo ""
# fi
