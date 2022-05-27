| Debian i3 Minimal - Desktop                                         | Debian i3 Minimal - Login                                       |
| ------------------------------------------------------------------- | --------------------------------------------------------------- |
| ![Debian i3 Minimal - Desktop](pictures-minimal-debian/desktop.jpg) | ![Debian i3 Minimal - Login](pictures-minimal-debian/login.jpg) |

#### Links to files to GitHub

-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/001_software_common_shared_deb_linux.sh
-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/002_software_webdev_shared_deb_linux.sh
-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/003_software_i3_min_debian.sh
-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/004_software_i3_max_debian.sh
-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/005_download_fonts_deb_linux.sh
-   https://github.com/freddan88/fredrik.linux.files/blob/main/i3/006_update_i3_config_minimal.sh

<br/>

#### Debian/Ubuntu Min Software i3 installation

##### Install common software

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/001_software_common_shared_deb_linux.sh | sudo sh
```

##### Install software for a minimal debian-installation

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/003_software_i3_min_debian.sh | sudo sh
```

##### Install common fonts

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/005_download_fonts_deb_linux.sh | sudo sh
```

##### Update configuration for i3-wm (minimal-installation)

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/006_update_i3_config_minimal.sh | sh
```

##### Disabling the graphical login

```bash
sudo update-rc.d slim disable
```

#### Debian/Ubuntu Max Software i3 installation

```bash
# curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/001_software_common_shared_deb_linux.sh | sudo sh
# curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/003_software_i3_max_debian.sh | sudo sh
# curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/005_download_fonts_deb_linux.sh | sudo sh
```

#### Debian/Ubuntu Web Developer Software

```bash
curl -fsSL https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/002_software_webdev_shared_deb_linux.sh | sudo sh
```
