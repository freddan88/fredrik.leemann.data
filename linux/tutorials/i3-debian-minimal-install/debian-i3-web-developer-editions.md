## Debian Linux Web-Developers Edition

> Tutorial to install Debian with either XFCE-desktop + i3-wm or LXDE-packages + i3-wm

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links: |                                                                                      |
| --------- | ------------------------------------------------------------------------------------ |
| WebPage:  | [leemann.se/fredrik](http://www.leemann.se/fredrik)                                  |
| LinkedIn: | [linkedin.com/fredrik-leemann](https://se.linkedin.com/in/fredrik-leemann-821b19110) |
| GitHub:   | [github.com/freddan88](https://github.com/freddan88)                                 |

Tutorials are tested for:

-   Debian Linux 11 (bullseye) 64Bit

### Installation

##### First download and install Debian Linux from any of the links below:

-   [Download Debian Linux ISO (netinst)](https://www.debian.org/download)
-   [Download Debian Linux ISO (nonfree)](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware)

#### 1. Update system, install packages and add your user as a sudo-user (run as root) OBS: Will reboot your computer!

```bash
su -
```

```bash
apt update && apt install wget sudo -y && usermod -aG sudo <YOUR_USER_NAME> && apt upgrade -y && reboot
```

#### OPTION 1: Install Debian Linux with XFCE-desktop and i3 window-manager

##### 1.1 Install Debian on your computer with the XFCE-desktop

##### 1-2. Download the installation-script (run as user)

```bash
cd && wget -O debian-i3_x64.sh https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/debian-i3-xfce_x64.sh
```

#### OPTION 2: Install Debian Linux with LXDE-panel and i3 window-manager

##### 1.1 Install Debian on your computer with no desktop

##### 1.2 Download the installation-script (run as user)

```bash
cd && wget -O debian-i3_x64.sh https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/debian-i3-lxde_x64.sh
```

#### 2. Download the main-installation script (run as user)

```bash
cd && wget https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/debian-i3-main_x64.sh
```

#### 3. Execute installation-scripts as sudo (run as user)

```bash
cd && chmod 754 debian*_x64.sh && sudo ./debian-i3_x64.sh install && sudo ./debian-i3-main_x64.sh install
```

#### 4. Download and install tools (run as user)

##### Oh My Zsh: https://ohmyz.sh

```bash
cd && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

##### Zsh extension: autosuggestions: https://github.com/zsh-users/zsh-autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

##### Node & npm version control: https://github.com/nvm-sh/nvm

```bash
cd /tmp && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

#### 5. Download and update your zsh-config (run as user)

```bash
cd && sudo ./debian-i3-main_x64.sh zsh-config && xdg-user-dirs-update 2> /dev/null
```

#### 6. Cleanup system and update packages (run as user) OBS: Will reboot your computer!

```bash
cd && rm -f debian-i3* && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo reboot
```

#### 7. Command to run after reboot (run as user)

```bash
nvm install --lts && nvm alias default node && nvm use node
```

#### VM:S using virtualbox will have to install those to be able to install: VIRTUALBOX GUEST EXTENSIONS

```bash
sudo apt install linux-headers-$(uname -r) make gcc dkms build-essential -y
```

#### Games

```bash
sudo apt install openarena 0ad warzone2100 frozen-bubble hedgewars supertux supertuxkart quadrapassel xmoto pinball pinball-table-gnu pinball-table-hurd gnome-nibbles teeworlds -y
```

#### Links

-   https://www.reddit.com/r/debian/comments/pn1oia/what_happened_to_libappindicator31_in_debian_11
-   https://github.com/freddan88/debian-linux-i3-develolper/blob/master/debian_install_i3-2.txt
-   http://wuwablog.blogspot.com/2018/07/atftpd-vs-tftpd-hpa.html
-   https://github.com/denesb/xfce4-i3-workspaces-plugin
-   https://www.popot.org/get_the_games.php?game=SDLPoP
-   https://itsfoss.com/change-default-terminal-ubuntu
-   https://thevaluable.dev/i3-config-mouseless
-   https://github.com/freddan88/xubuntu-i3wm
-   https://wiki.debian.org/NetworkManager
-   http://www.secretmaryo.org
