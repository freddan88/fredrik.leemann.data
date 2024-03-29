## Linux Debian i3 Minimal Installation

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links |                                                      |
| -------- | ---------------------------------------------------- |
| WebPage: | [fredrik.leemann.se](https://fredrik.leemann.se)     |
| GitHub:  | [github.com/freddan88](https://github.com/freddan88) |

**Tested on:**

-   Debian Linux 11 (bullseye) 64Bit (nonFree Software)

---

**Download the non-free version of debian from this link**

> Download: [unofficial-debian-linux-iso-including-firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd)

**Install Debian on your computer**

-   Go with a bare-bone installation with no desktop environment

-   Keep the root-password blank. By doing this it will:

    -   Add your user to the sudoers-group automatically

    -   Disable the root-account for the new installation

    **_Screenshot from the software selection screen during installation_**

> Select SSH server and standard system utilities or only standard system utilities

![](images/debian-minimal-software-selection-screen.png)

**Check your sources**

> After first boot you may need to append `main contrib non-free` in sources.list

Example

```bash
sudo nano /etc/apt/sources.list
```

> If sudo ain´t working you need to login as root and add your user to the group

```bash
apt install sudo && usermod -aG sudo <YOUR_USER_NAME> && reboot
```

![](images/debian-minimal-apt-sources.png)

### Install software

After the installation you shall login through the cli and run the below commands:

```bash
sudo apt update && sudo apt install wget curl git -y
```

**Download scripts to set-up base for minimal Debian installation**

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/universal"
cd /tmp && wget $url/debian-based/debian-minimal-install/root_debian_minimal_install_all.sh
cd /tmp && wget $url/debian-based/debian-minimal-install/user_debian_update_config_all.sh
cd /tmp && wget $url/debian-based/debian-minimal-install/user_debian_update_config_i3.sh
cd /tmp && wget $url/root_linux_fonts_install_all.sh
```

> Sources: [linux-scripts-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/scripts)

**Run scripts to install minimal Debian installation**

```bash
cd /tmp && sudo chmod 754 root_*.sh user_*.sh
cd /tmp && sudo ./root_debian_minimal_install_all.sh
cd /tmp && sudo ./root_linux_fonts_install_all.sh
cd /tmp && ./user_debian_update_config_all.sh
cd /tmp && ./user_debian_update_config_i3.sh
```

> You can run `user_debian_update_config_all.sh` and `user_debian_update_config_i3.sh` again to update configurations

**Install Oh My Zsh**

```bash
cd /tmp && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

> Source: [https://ohmyz.sh](https://ohmyz.sh)

**Install Extensions for Oh My Zsh**

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

> Source: [zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)

```bash
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
```

> Source: [zsh-git-open: Open remote repository from zsh-terminal](https://github.com/paulirish/git-open)

**Download and update your zsh-config**

```bash
cd && wget -O .zshrc https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/shells/zshrc.sh
```

> Source: [zshrc-shell-script-github](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/configurations/shells/zshrc.sh)

_If the x-server ain´t running you can configure it to autostart in this file by changing: autostart_x to 1_

**Comment all network-interfaces that you would like network-manager to manage**

```bash
sudo nano /etc/network/interfaces
```

![](images/debian-minimal-install-network.png)

**Reboot your computer to apply new configurations and load the gui**

```bash
sudo reboot
```

### Extra (Optional)

> Tutorial: [Linux Debian web-developer utilities - Install webdev software and scripts](../debian-webdev-tutorial.md)

**My favorite linux games**

```bash
sudo apt install openarena nexuiz alien-arena alienblaster sauerbraten 0ad warzone2100 frozen-bubble -y
sudo apt install hedgewars teeworlds supertux supertuxkart extremetuxracer quadrapassel -y
sudo apt install pinball pinball-table-gnu pinball-table-hurd xmoto gnome-nibbles -y
```

**Install virtualbox guest-additions if you are using a VM through virtualbox**

> This will only prepare for installation you need to install from media yourself

```bash
sudo apt install linux-headers-$(uname -r) make gcc dkms build-essential -y
```

**Example on how to install virtualbox guest-additions from CLI**

```bash
cd /tmp && mkdir -p vbox
cd /tmp && sudo mount /dev/cdrom vbox
cd /tmp/vbox && sudo ./VBoxLinuxAdditions.run
cd /tmp && sudo umount -f vbox && rm -rf vbox
```

> OBS! You need to `insert the Guest Additions CD image` before running those commands

**Install and start spice-vdagent if you are using a VM in example KVM**

> This service needs to autostart through some configuration-file

```bash
sudo apt install spice-vdagent -y && sudo /etc/init.d/spice-vdagent start
```

**Speed up apt-package-manager using the nala-project**

-   [Nala package manager installation and usage - Tutorial by: Chris Titus Tech](https://christitus.com/stop-using-apt)
-   [Nala package manager installation - Tutorial by: Jake Redfield](https://trendoceans.com/nala-package-manager)
-   [Nala package manager installation - Official tutorial](https://gitlab.com/volian/nala/-/wikis/Installation)

For Debian Linux 11 (bullseye) 64Bit

1. Add Custom Repository
2. Install the legacy-package

> Project: [Volian Linux / nala · GitLab](https://gitlab.com/volian/nala)

---

| Example desktop configuration |                           |
| ----------------------------- | ------------------------- |
|                               |                           |
| **Theme**                     |                           |
| Icons:                        | elementary Xfce dark      |
| System:                       | Arc-Dark                  |
|                               |                           |
| **Fonts**                     |                           |
| Terminal:                     | Cascadia Mono SemiBold 12 |
| System:                       | Ubuntu Medium 11          |

![](images/debian-minimal-install-i3-01.png)

### Important keybindings

_i3keybindings.sh will automatically run on every login and restart_

| Keybinding                                            | Program / Script     | Description                              |
| ----------------------------------------------------- | -------------------- | ---------------------------------------- |
| <kbd>super</kbd> + <kbd>enter</kbd>                   | Xfce4 terminal       | Open a new terminal-window               |
| <kbd>super</kbd> + <kbd>e</kbd>                       | thunar               | Open the file-browser thunar             |
| <kbd>super</kbd> + <kbd>w</kbd>                       | google-chrome        | Open the web-browser google-chrome       |
| <kbd>super</kbd> + <kbd>q</kbd>                       | kill                 | Close focused window                     |
| <kbd>super</kbd> + <kbd>s</kbd>                       | rofi-system-menu     | Open the system menu                     |
| <kbd>super</kbd> + <kbd>ctrl</kbd> + <kbd>space</kbd> | catfish              | Search for files                         |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>space</kbd>  | rofi -show run       | Search for commands                      |
| <kbd>super</kbd> + <kbd>space</kbd>                   | xfce4-appfinder      | Search for applications                  |
| <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>q</kbd>       | rofi-power-menu      | Lock/Logout/Shutdown/Reboot              |
|                                                       |                      |                                          |
| **Keybindings specific to the i3 window manager**     |                      |                                          |
| <kbd>super</kbd> + <kbd>b</kbd>                       | google-chrome + keys | Read all keybindings in i3 using chrome  |
| <kbd>super</kbd> + <kbd>v</kbd>                       | i3keybindings.sh     | Generate a new list of keybindings in i3 |

### Some of the programs

_Please read the source of the scripts above to get a full list of programs_

-   [google-chrome-stable](https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)
-   [xfce4-panel-profiles](http://ftp.ports.debian.org/debian-ports/pool/main/x/xfce4-panel-profiles)
-   [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl)

### Links and resources

-   [unix.stackexchange.com - automatically-login-via-command-line](https://unix.stackexchange.com/questions/401759/automatically-login-on-debian-9-2-1-command-line)
-   [github.com/denesb - Workspaces plugin for xfce4 and the i3 window manager.](https://github.com/denesb/xfce4-i3-workspaces-plugin)
-   [Rofi command/application-launcher Tutorial](https://linuxconfig.org/how-to-use-and-install-rofi-on-linux-tutorial)
-   [SDLPoP · Prince of Persia: Original Trilogy](https://www.popot.org/get_the_games.php?game=SDLPoP)
-   [Configuring i3 Window Manager: a Complete Guide](https://thevaluable.dev/i3-config-mouseless)
-   [i3 improved tiling wm - user’s Guide](https://i3wm.org/docs/userguide.html)
-   [NetworkManager - Debian Wiki](https://wiki.debian.org/NetworkManager)
-   [http://www.secretmaryo.org](http://www.secretmaryo.org)
