## Linux Debian i3 Minimal Installation

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links  |                                                                                      |
| --------- | ------------------------------------------------------------------------------------ |
| WebPage:  | [leemann.se/fredrik](http://www.leemann.se/fredrik)                                  |
| LinkedIn: | [linkedin.com/fredrik-leemann](https://se.linkedin.com/in/fredrik-leemann-821b19110) |
| GitHub:   | [github.com/freddan88](https://github.com/freddan88)                                 |

**Tested on:**

- Debian Linux 11 (bullseye) 64Bit (nonFree Software)

---

**Download the non-free version of debian from this link**

[unofficial-non-free-netinst-cd-including-firmware-debian-linux](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/)

**Install Debian on your computer**

- Go with a bare-bone installation with no desktop environment

- Keep the root-password blank. By doing this it will:

  - Add your user to the sudoers-group automatically

  - Disable the root-account for the new installation

  **_Screenshot from the software selection screen during installation_**

> Select SSH server and standard system utilities or only standard system utilities

![](images/i3-debian-minimal-software-selection-screen.png)

**Check your sources**

> After first boot you may need to append 'main contrib non-free' in sources.list

![](images/i3-debian-minimal-apt-sources.png)

### Install software

After the installation you shall login through the cli and run the below commands:

```bash
sudo apt update && sudo apt install curl sudo wget -y
```

> If sudo ain´t working you need to login as root and add your user to the group

```bash
usermod -aG sudo <YOUR_USER_NAME> && reboot
```

**Download scripts to set-up base for minimal Debian installation**

```bash
url='https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/debain-minimal-install'
cd /tmp && wget $url/debain_minimal_software_all.sh
cd /tmp && wget $url/debian_update_config_all.sh
cd /tmp && wget $url/debian_update_config_i3.sh
```

Sources: [debain-minimal-install-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/scripts/debain-minimal-install)

**Run scripts to set-up base for minimal Debian installation**

```bash
cd /tmp && sudo chmod 764 debian*.sh && sudo ./debain_minimal_software_all.sh && sudo ./debian_update_config_all.sh && ./debian_update_config_i3.sh
```

<!-- cd /tmp && sudo chmod 764 debian*.sh && sudo ./debain*all.sh && ./debian_update_config_i3.sh -->

**Install i3 window-manager on Debian**

```bash
sudo apt install i3 i3status -y
```

**Install Oh My Zsh**

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Source: [https://ohmyz.sh](https://ohmyz.sh)

**Install Extension for Oh My Zsh**

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Source: [zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)

**Download and update your zsh-config**

```bash
cd && wget -O .zshrc https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/shells/zshrc
```

Source: [fredrik.leemann.data/zshrc.txt at GitHub](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/configurations/shells/zshrc.txt)

> Tip: You can configure autostart of x in this file by changing: autostart_x to 1

### Extra (Optional)

**Install web-developer software**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/005_software_webdev_deb.sh | sudo sh
```

Source: [005_software_webdev_deb.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/005_software_webdev_deb.sh)

**Download web-developer scripts**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/006_download_webdev_scripts.sh | sudo sh
```

Source: [006_download_webdev_scripts.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/006_download_webdev_scripts.sh)

**Install NVM (Node Version Manager)**

```bash
cd /tmp && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Source: [GitHub - nvm-sh/nvm: Node Version Manager](https://github.com/nvm-sh/nvm)

> Reboot your computer with the command `sudo reboot` and run below after

```bash
nvm install --lts && nvm alias default node && nvm use node
```

**Disabling the graphical login**

```bash
sudo update-rc.d slim disable
```

**Configure Debian to log in automatically through cli**

[unix.stackexchange.com - automatically-login-on-debian-9-2-1-command-line](https://unix.stackexchange.com/questions/401759/automatically-login-on-debian-9-2-1-command-line)

**My favorite linux games**

```bash
sudo apt install openarena 0ad warzone2100 frozen-bubble hedgewars supertux supertuxkart quadrapassel xmoto pinball pinball-table-gnu pinball-table-hurd gnome-nibbles teeworlds -y
```

**Install virtualbox guest extension if you are using a VM in virtualbox**

> This will only prepare for installation you need to install from media yourself

```bash
sudo apt install linux-headers-$(uname -r) make gcc dkms build-essential -y
```

**Install and start spice-vdagent if you are using a VM in example KVM**

> This service needs to autostart through the i3-configuration file

```bash
sudo apt install spice-vdagent -y && sudo /etc/init.d/spice-vdagent start
```

**Speed up apt-package-manager using the nala-project**

Project: [Volian Linux / nala · GitLab](https://gitlab.com/volian/nala)

---

### Example desktop configurations

| Fonts     |                           |
| --------- | ------------------------- |
| Terminal: | Cascadia Mono SemiBold 12 |
| System:   | Ubuntu Medium 11          |

| Debian i3 Minimal - Desktop 01                       | Debian i3 Minimal - Desktop 02                       |
| ---------------------------------------------------- | ---------------------------------------------------- |
| ![](images/i3-debian-minimal-desktop-example-01.png) | ![](images/i3-debian-minimal-desktop-example-02.png) |

| Debian i3 Minimal - Login-screen 01               | Debian i3 Minimal - Login-screen 02         |
| ------------------------------------------------- | ------------------------------------------- |
| ![](images/i3-debian-minimal-graphical-login.png) | ![](images/i3-debian-minimal-cli-login.png) |

### Important keybindings

_i3keybindings.sh will automaticaly run on every login and restart_

| Keybinding                                      | Program / Scriipt | Description                    |
| ----------------------------------------------- | ----------------- | ------------------------------ |
| <kbd>super</kbd> + <kbd>enter</kbd>             | Xfce4 terminal    | Open a new terminal-window     |
| <kbd>super</kbd> + <kbd>space</kbd>             | xfce4-appfinder   | Search for applications        |
| <kbd>super</kbd> + <kbd>q</kbd>                 | kill              | Close focused window           |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>g</kbd> | i3keybindings.sh  | Generate a list of keybindings |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>k</kbd> | google-chrome     | Read all i3 keybindings        |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>l</kbd> | slimlock          | Logout from the system         |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>p</kbd> | poweroff          | Shutdown the system            |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>r</kbd> | reboot            | Reboot the system              |

### Some of the programs

_Please read the source of the scripts above to get a full list of programs_

- [google-chrome-stable](https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb "Link to download the Latest Stable Build of Google's Web Browser for deb-linux 64Bit")
- [xfce4-panel-profiles](http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb "Save/restore xfce4-panel-configurations")
- [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl "Control pulseaudio volume from the shell or keyboard")
- [marktext](https://github.com/marktext/marktext "Edit and Create Markdown-documents")
- [mongodb-compass](https://www.mongodb.com/try/download/compass "Manage MongoDB Databases")
- [Visual Studio Code](https://code.visualstudio.com "My Preferred Code Editor")
- [DBeaver](https://dbeaver.io/download "Universal Database Management Tool")

### Links and resources

- [reddit.com - What happened to libappindicator3-1 in Debian 11](https://www.reddit.com/r/debian/comments/pn1oia/what_happened_to_libappindicator31_in_debian_11)
- [wuwablog.blogspot.com - atftpd vs tftpd-hpa](http://wuwablog.blogspot.com/2018/07/atftpd-vs-tftpd-hpa.html)
- [github.com/denesb - Workspaces plugin for xfce4 and the i3 window manager.](https://github.com/denesb/xfce4-i3-workspaces-plugin)
- [SDLPoP · Prince of Persia: Original Trilogy](https://www.popot.org/get_the_games.php?game=SDLPoP)
- [How to Change the Default Terminal in Ubuntu - FOSS](https://itsfoss.com/change-default-terminal-ubuntu)
- [Configuring i3 Window Manager: a Complete Guide](https://thevaluable.dev/i3-config-mouseless)
- [NetworkManager - Debian Wiki](https://wiki.debian.org/NetworkManager)
- [http://www.secretmaryo.org](http://www.secretmaryo.org)
