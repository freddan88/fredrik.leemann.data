## Linux Debian web-developer utilities

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links  |                                                                                      |
| --------- | ------------------------------------------------------------------------------------ |
| WebPage:  | [fredrik.leemann.se](https://fredrik.leemann.se)                                     |
| LinkedIn: | [linkedin.com/fredrik-leemann](https://se.linkedin.com/in/fredrik-leemann-821b19110) |
| GitHub:   | [github.com/freddan88](https://github.com/freddan88)                                 |

**Tested on:**

- Debian Linux 11 (bullseye) 64Bit (nonFree Software)

---

**Download scripts to set-up webdev-utilities for Debian**

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/scripts/debian-webdev-install"
cd /tmp && wget $url/debian_root_webdev_install_all.sh
cd /tmp && wget $url/debian_root_webdev_scripts_all.sh
cd /tmp && wget $url/debian_user_webdev_scripts_all.sh
```

> Sources: [debian-webdev-install-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/scripts/debian-webdev-install)

**Run scripts to install webdev-utilities for Debian**

```bash
cd /tmp && sudo chmod 754 debian*.sh
cd /tmp && sudo ./debian_root_webdev_install_all.sh
cd /tmp && sudo ./debian_root_webdev_scripts_all.sh
cd /tmp && ./debian_user_webdev_scripts_all.sh
```

> You can run `debian_root_webdev_scripts_all.sh` and `debian_user_webdev_scripts_all.sh` again to update those scripts

**Install NVM (Node Version Manager)**

```bash
cd /tmp && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

> Source: [GitHub - nvm-sh/nvm: Node Version Manager](https://github.com/nvm-sh/nvm)

**Reboot your computer to apply new configurations and settings**

```bash
sudo reboot
```

> After a successful reboot you shall be able to install node using nvm

```bash
nvm install --lts && nvm alias default node && nvm use node
```

### Some of the programs

_Please read the source of the scripts above to get a full list of programs_

- [marktext](https://github.com/marktext/marktext "Edit and Create Markdown-documents")
- [mongodb-compass](https://www.mongodb.com/try/download/compass "Manage MongoDB Databases")
- [Visual Studio Code](https://code.visualstudio.com "My Preferred Code Editor")
- [DBeaver](https://dbeaver.io/download "Universal Database Management Tool")
