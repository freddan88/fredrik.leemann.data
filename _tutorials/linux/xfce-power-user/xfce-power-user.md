## Linux XFCE Power User

> I call this project XFCE POWER USER because of handy keybindings for applications as well as the window manager.<br/>
> The layout for the xfce-desktop is inspired by various window managers like [i3-wm](https://i3wm.org/)<br/>

![](images/desktop.png)

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links |                                                      |
| -------- | ---------------------------------------------------- |
| WebPage: | [fredrik.leemann.se](https://fredrik.leemann.se)     |
| GitHub:  | [github.com/freddan88](https://github.com/freddan88) |

<br/>

#### Tested on

-   Linux Mint XFCE 21.2 64Bit
-   Debian 12 XFCE 64BIT (netinst)
-   Xubuntu 22.04 64Bit

#### Download Distributions

-   [Linux Mint XFCE](https://linuxmint.com/download.php)
-   [Debian](https://www.debian.org/distrib/)
-   [Xubuntu](https://xubuntu.org/)

<br/>

#### Table of contents

-   [Installation](#installation)
-   [Keybindings](#keybindings)
-   [Extra packages](#extra-packages)
-   [Installed packages](#installed-packages)

<br/>

### Installation

> Those scripts are intended to be run after installation and will change your configuration and packages.

<br/>

#### Install and upgrade packages

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install git curl sudo wget -y
sudo apt clean -y && sudo apt autoremove -y
```

> You may want to reboot your computer after those steps to be sure you have a clean environment

<br/>

#### Download scripts

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/xfce_xpu"
cd /tmp && wget $url/install_xfce_xpu_sudo.sh
cd /tmp && wget $url/install_xfce_xpu_user.sh
```

> You may configure parts in the scripts before running them. Please edit to your liking

<br/>

#### Run scripts

```bash
cd /tmp && sudo chmod 754 install_xfce_xpu*.sh
cd /tmp && sudo ./install_xfce_xpu_sudo.sh
cd /tmp && ./install_xfce_xpu_user.sh
```

> Please read the scripts before running them. They will change your configurations

`Sources:` [linux-scripts-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/xfce_xpu)

<br/>

#### Reboot you computer after running the scripts either from gui or from terminal

```bash
sudo reboot
```

<br/>

### Keybindings

<br/>

### Extra packages

#### Install spotify from various sources

-   [Download and install via apt](https://www.spotify.com/se/download/linux)
-   [Download and install as a flatpack](https://flathub.org/apps/com.spotify.Client)
-   [Download and install as a snap-package ](https://snapcraft.io/spotify)

<br/>

#### Install various games

```bash
sudo apt install quadrapassel frozen-bubble openarena supertux supertuxkart warzone2100 gnome-nibbles
sudo apt install 0ad xmoto pinball pinball-table-gnu pinball-table-hurd hedgewars teeworlds
```

<br/>

#### Speed up apt-package-manager using the nala-project

> Parallel downloads from multiple sources and new appearance

```bash
sudo apt install nala
```

> This command will scan for mirrors near you and display a list

```bash
sudo nala fetch
```

Project: [Volian Linux / nala - GitLab](https://gitlab.com/volian/nala)

<br/>

#### Install restricted codecs and packages

> Debian

```bash
sudo apt-add-repository contrib non-free
sudo apt install ttf-mscorefonts-installer unrar
```

> Ubuntu / Linux-mint

```bash
sudo add-apt-repository multiverse
sudo apt install ubuntu-restricted-extras
```

<br/>

#### Install new greeter as login window and update settings ubuntu/debian

> I tend to like the looks of slick-greeter for lightdm rather than whats included in ubuntu/debian<br/>
> If you also wan´t to change this you can install and configure with the commands below<br/>
> lightdm and the greeter is the login-window in: ubuntu / debian / linux-mint

```bash
sudo apt install slick-greeter
cd /etc/lightdm && sudo rm -f lightdm.conf
sudo wget https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/display_managers/lightdm/lightdm.conf
```

![](images/login.png)

<br/>

#### Install dictionaries for libre office

> Example for swedish dictionary

```bash
sudo apt install libreoffice-help-sv mythes-sv hunspell-sv-se hyphen-sv -y
```

-   https://packages.debian.org/source/sid/libreoffice-dictionaries
-   https://extensions.libreoffice.org/?Tags%5B%5D=50

<br/>

#### Install virtualbox guest extension if you are using a VM in virtualbox

> This will only prepare for installation you need to install from media yourself

```bash
sudo apt install linux-headers-$(uname -r) make gcc dkms build-essential -y
```

<br/>

### Installed packages

<br/>
