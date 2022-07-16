| Debian i3 Minimal - Desktop                                         | Debian i3 Minimal - Login                                       |
| ------------------------------------------------------------------- | --------------------------------------------------------------- |
| ![Debian i3 Minimal - Desktop](pictures-minimal-debian/desktop.jpg) | ![Debian i3 Minimal - Login](pictures-minimal-debian/login.jpg) |

```bash
sudo apt update && sudo apt install curl -y
```

Install fonts

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/001_download_fonts_deb_linux.sh | sudo sh
```

Install software

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/002_software_i3_deb_minimal.sh | sudo sh
```

Configure system

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/003_configure_system_deb_linux.sh | sudo sh
```

Update i3 config

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/004_update_i3_config_minimal.sh | sh
```

#### Extra (Optional)

Terminal font
Cascadia Mono SemiBold 12

Default font (system)
Ubuntu Medium 11

Install web-developer software

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/005_software_webdev_deb_linux.sh | sudo sh
```

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/006_update_webdev_software_bash.sh | sudo sh
```

Disabling the graphical login

```bash
sudo update-rc.d slim disable
```

Debian automatically login through cli
https://unix.stackexchange.com/questions/401759/automatically-login-on-debian-9-2-1-command-line
