## Linux Debian web-developer utilities

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links  |                                                                                      |
| --------- | ------------------------------------------------------------------------------------ |
| WebPage:  | [leemann.se/fredrik](http://www.leemann.se/fredrik)                                  |
| LinkedIn: | [linkedin.com/fredrik-leemann](https://se.linkedin.com/in/fredrik-leemann-821b19110) |
| GitHub:   | [github.com/freddan88](https://github.com/freddan88)                                 |

**Tested on:**

- Debian Linux 11 (bullseye) 64Bit (nonFree Software)

---

**Download scripts to set-up webdev-utilities for Debian**

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/debian-webdev-install"
cd /tmp && wget $url/debian_root_webdev_install_all.sh
cd /tmp && wget $url/debain_root_webdev_scripts_all.sh
```

Sources: [debian-webdev-install-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/scripts/debian-webdev-install)

**Run scripts to install webdev-utilities for Debian**

```bash
cd /tmp && sudo chmod 764 debian*.sh
cd /tmp && sudo ./debian_root_webdev_install_all.sh
cd /tmp && sudo ./debain_root_webdev_scripts_all.sh
```

You can run `debain_root_webdev_scripts_all.sh` again to update those scripts

**Install NVM (Node Version Manager)**

```bash
cd /tmp && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Source: [GitHub - nvm-sh/nvm: Node Version Manager](https://github.com/nvm-sh/nvm)

**Reboot your computer to apply new configurations and settings**

```bash
sudo reboot
```

> After a successful reboot you shall be able to install node using nvm

```bash
nvm install --lts && nvm alias default node && nvm use node
```
