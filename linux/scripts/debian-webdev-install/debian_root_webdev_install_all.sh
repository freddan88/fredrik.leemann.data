#!/usr/bin/env bash

url_marktext_package="https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-amd64.deb"
url_mongodb_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb"
url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
url_latest_dbeaver="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"

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
echo "INSTALLING WEBDEV SOFTWARE" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

linux_distribution=$(lsb_release -is)

if [ "$linux_distribution" = "Debian" ]; then
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

if [ "$linux_distribution" = "Ubuntu" ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

if [ "$linux_distribution" = "Linuxmint" ]; then
  ubuntu_codename=$(grep UBUNTU_CODENAME /etc/os-release | cut -d"=" -f2)
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $ubuntu_codename stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc >/dev/null
sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'

apt update -qq && apt install docker-ce docker-ce-cli containerd.io ghostscript pwgen openssl bat jq pandoc redis gh github-desktop -y
apt install apache2 libapache2-mpm-itk libapache2-mod-php libsodium23 sqlite3 sqlitebrowser mariadb-client mariadb-server php php-sqlite3 php-mysql -y
apt install php-cli php-common php-xdebug php-bcmath php-curl php-soap php-mbstring php-opcache php-readline php-xml php-zip php-pear php-cgi php-phpseclib -y
apt install php-imagick php-gd imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 -y
apt install libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y

apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub rest.insomnia.Insomnia --noninteractive -y
flatpak install flathub com.github.alecaddd.sequeler --noninteractive -y

usermod -aG docker $SUDO_USER

if [ ! -f "/usr/bin/marktext" ]; then
  cd /tmp && wget $url_marktext_package
  apt install ./marktext-amd64.deb -y
fi

if [ ! -f "/usr/bin/mongodb-compass" ]; then
  cd /tmp && wget $url_mongodb_compass
  apt install ./mongodb-compass_*_amd64.deb -y
fi

if [ ! -f "/usr/bin/code" ]; then
  cd /tmp && wget -O vscode_amd64.deb $url_latest_vscode
  apt install ./vscode_amd64.deb -y
fi

if [ ! -f "/usr/bin/dbeaver-ce" ]; then
  cd /tmp && wget $url_latest_dbeaver
  apt install ./dbeaver-ce_*_amd64.deb -y
fi

cd /tmp && rm -f dbeaver-ce_*_amd64.deb vscode_amd64.deb mongodb-compass_*_amd64.deb marktext-amd64.deb

echo " "
echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable apache2.service
systemctl stop apache2.service

echo " "
echo "DISABLING MARIADB DATABASE SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable mariadb.service
systemctl stop mariadb.service

echo " "
echo "DISABLING REDIS DATABASE SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable redis-server.service
systemctl stop redis-server.service

echo " "
echo "DONE!"
echo " "
