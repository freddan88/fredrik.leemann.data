## Linux XFCE Power User

---

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links |                                                      |
| -------- | ---------------------------------------------------- |
| WebPage: | [fredrik.leemann.se](https://fredrik.leemann.se)     |
| GitHub:  | [github.com/freddan88](https://github.com/freddan88) |

**Tested on:**

-   Linux Mint XFCE 64Bit
-   Xubuntu 64 Bit

---

```bash
sudo apt update && sudo apt install curl sudo wget -y
```

**Download scripts to set-up XFCE Power User**

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/xfce_xpu"
cd /tmp && wget $url/install_xfce_xpu_sudo.sh
cd /tmp && wget $url/install_xfce_xpu_user.sh
```

> Sources: [linux-scripts-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/xfce_xpu)

**Run scripts to install webdev-utilities for Debian**

```bash
cd /tmp && sudo chmod 754 install_xfce_xpu*.sh
cd /tmp sudo ./install_xfce_xpu_sudo.sh
cd /tmp . /install_xfce_xpu_user.sh
```
