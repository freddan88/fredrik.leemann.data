## Linux XFCE Power User

---

[License: MIT](https://choosealicense.com/licenses/mit)

| My Links |                                                      |
| -------- | ---------------------------------------------------- |
| WebPage: | [fredrik.leemann.se](https://fredrik.leemann.se)     |
| GitHub:  | [github.com/freddan88](https://github.com/freddan88) |

<br/>

**Tested on:**

-   Linux Mint XFCE 21.2 64Bit
-   Xubuntu 22.04 64 Bit

<br/>

**Download Distributions**

-   [Linux Mint XFCE](https://linuxmint.com/)
-   [Xubuntu](https://xubuntu.org/)

---

<br/>

**Install and upgrade packages**

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install git curl sudo wget -y
sudo apt clean -y && sudo apt sudo apt autoremove -y
```

> You may want to reboot your computer after those steps to be sure you have a clean environment

<br/>

**Download scripts**

```bash
url="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/xfce_xpu"
cd /tmp && wget $url/install_xfce_xpu_sudo.sh
cd /tmp && wget $url/install_xfce_xpu_user.sh
```

> Sources: [linux-scripts-github](https://github.com/freddan88/fredrik.leemann.data/tree/main/linux/xfce_xpu)

<br/>

**Run scripts**

```bash
cd /tmp && sudo chmod 754 install_xfce_xpu*.sh
cd /tmp && sudo ./install_xfce_xpu_sudo.sh
cd /tmp && ./install_xfce_xpu_user.sh
```

> Please read the scripts before running them. They will change your configurations
