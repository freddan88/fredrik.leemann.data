#!/usr/bin/env bash

url_mongodb_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb"
url_latest_vscode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
url_latest_dbeaver="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"

# Link to file on GitHub
# https://github.com/freddan88/fredrik.linux.files/blob/main/i3/002_software_webdev_shared_deb_linux.sh

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

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

if [[ $(lsb_release -is) == "Debian" ]]; then
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

if [[ $(lsb_release -is) == "Ubuntu" ]]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

apt install docker-ce docker-ce-cli containerd.io -y
apt install apache2 libapache2-mpm-itk libapache2-mod-php libsodium23 sqlite3 sqlitebrowser mysql-client -y
apt install php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} -y
apt install imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 -y
apt install libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y

apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub rest.insomnia.Insomnia --noninteractive -y
flatpak install flathub com.github.alecaddd.sequeler --noninteractive -y

cd /tmp && wget -q $url_latest_dbeaver && apt install ./dbeaver-ce_*_amd64.deb -y
cd /tmp && wget -q $url_mongodb_compass && apt install ./mongodb-compass_*_amd64.deb -y
cd /tmp && wget -q -O vscode_amd64.deb $url_latest_vscode && apt install ./vscode_amd64.deb -y
cd /tmp && rm -f dbeaver-ce_*_amd64.deb vscode_amd64.deb mongodb-compass_*_amd64.deb

echo " "
echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
echo " "

systemctl disable apache2.service
systemctl stop apache2.service

usermod -aG docker $SUDO_USER

echo " "
echo "DONE!"
echo " "
