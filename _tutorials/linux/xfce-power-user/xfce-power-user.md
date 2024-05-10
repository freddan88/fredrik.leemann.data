## Linux XFCE Power User

> I call this project XFCE POWER USER because of handy keybindings for applications as well as the window manager.<br/>
> The layout for the xfce-desktop is inspired by various window managers like [i3-wm](https://i3wm.org/)<br/>

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links |                                                      |
| -------- | ---------------------------------------------------- |
| WebPage: | [fredrik.leemann.se](https://fredrik.leemann.se)     |
| GitHub:  | [github.com/freddan88](https://github.com/freddan88) |

#### Tested on

-   Linux Mint XFCE 21.2 64Bit
-   Debian 12 XFCE 64BIT (netinst)
-   Xubuntu 22.04 64Bit

#### Download Distributions

-   [Linux Mint XFCE](https://linuxmint.com/download.php)
-   [Debian](https://www.debian.org/distrib/)
-   [Xubuntu](https://xubuntu.org/)

#### Table of contents

-   [Installation](#Installation)
-   [Keybindings](#Keybindings)
-   [Extra packages](#Extra-packages)
-   [Installed packages](#Installed-packages)

### Installation

> Those scripts are intended to be run after installation and will change your configuration and packages.

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

### Keybindings

### Extra packages

### Installed packages
