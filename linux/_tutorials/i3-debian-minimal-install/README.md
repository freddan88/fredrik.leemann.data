## My Debian i3 Minimal Installation

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links  |                                                                                      |
| --------- | ------------------------------------------------------------------------------------ |
| WebPage:  | [leemann.se/fredrik](http://www.leemann.se/fredrik)                                  |
| LinkedIn: | [linkedin.com/fredrik-leemann](https://se.linkedin.com/in/fredrik-leemann-821b19110) |
| GitHub:   | [github.com/freddan88](https://github.com/freddan88)                                 |

**Tested on:**

- Debian Linux 11 (bullseye) 64Bit (nonFree Software)

---

**1. Download Debian from this link**

https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/firmware-11.4.0-amd64-netinst.iso

**2. Install Debian on your computer**

- Go with a bare-bone installation with no desktop environment

- Keep the root-password blank. By doing this it will:
  
  - Add your user to the sudoers-group automatically
  
  - Disable the root-account for the new installation
  
  **_Screenshot from the software selection screen during installation_**

> Select SSH and standard system utilities or only standard system utilities

![](images/i3-debian-minimal-software-selection-screen.png)

**3. Install software from cli**

After the installation you shall login through the cli and run the below commands:

```bash
sudo apt update && sudo apt install curl sudo -y
```

> If sudo ain´t working you need to login as root and add your user to the group

```bash
usermod -aG sudo <YOUR_USER_NAME> && reboot
```

**Install fonts**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/001_install_fonts_deb.sh | sudo sh
```

Source: [001_install_fonts_deb.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/001_install_fonts_deb.sh)

**Install i3 software**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/002_software_i3_deb_min.sh | sudo sh
```

Source: [002_software_i3_deb_min.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/002_software_i3_deb_min.sh)

**Configure system**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/003_configure_system_deb.sh | sudo sh
```

Source: [003_configure_system_deb.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/003_configure_system_deb.sh)

**Update i3 config**

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/i3-debian-minimal-install/004_update_i3_config_min.sh | sh
```

Source: [004_update_i3_config_min.sh](https://github.com/freddan88/fredrik.leemann.data/blob/main/linux/scripts/i3-debian-minimal-install/004_update_i3_config_min.sh)

---

#### Extra (Optional)

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

**Disabling the graphical login**

```bash
sudo update-rc.d slim disable
```

**Configure Debian to log in automatically through cli**

[unix.stackexchange.com - automatically-login-on-debian-9-2-1-command-line](https://unix.stackexchange.com/questions/401759/automatically-login-on-debian-9-2-1-command-line)

---

#### Example desktop configurations

| Fonts    |                           |
| -------- | ------------------------- |
| Terminal | Cascadia Mono SemiBold 12 |
| System   | Ubuntu Medium 11          |

| Debian i3 Minimal - Desktop 01                       | Debian i3 Minimal - Desktop 02                              |
| ---------------------------------------------------- | ----------------------------------------------------------- |
| ![](images/i3-debian-minimal-desktop-example-01.png) | ![](images/i3-debian-minimal-software-selection-screen.png) |

| Debian i3 Minimal - Login-screen 01                         | Debian i3 Minimal - Login-screen 02                         |
| ----------------------------------------------------------- | ----------------------------------------------------------- |
| ![](images/i3-debian-minimal-software-selection-screen.png) | ![](images/i3-debian-minimal-software-selection-screen.png) |
