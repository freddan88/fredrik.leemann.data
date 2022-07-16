| Debian i3 Minimal - Desktop                                         | Debian i3 Minimal - Login                                       |
| ------------------------------------------------------------------- | --------------------------------------------------------------- |
| ![Debian i3 Minimal - Desktop](pictures-minimal-debian/desktop.jpg) | ![Debian i3 Minimal - Login](pictures-minimal-debian/login.jpg) |

##### Disabling the graphical login (Optional)

```bash
sudo update-rc.d slim disable
```

Terminal font
Cascadia Mono SemiBold 12

Default font (system)
Ubuntu Medium 11

```bash
sudo apt update && sudo apt install curl -y
```

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/001_software_i3_deb_minimal.sh | sudo sh
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/002_configure_i3_deb_minimal.sh | sudo sh
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/003_update_i3_config_minimal.sh | sudo sh
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/004_download_fonts_deb_linux.sh | sudo sh
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/005_software_webdev_deb_linux.sh | sh
```
