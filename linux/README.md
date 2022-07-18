### Scripts and configurations for various linux distributions

#### Saved Commands:

-   cat config-i3-xfce-v3.txt | grep ^bindsym
-   /etc/xdg/autostart (exo-open)
-   cat /etc/xdg/autostart/\* | grep Exec | cut -d"=" -f"2" > autostart.txt
-   https://flatpak.org

#### https://gist.github.com/keeferrourke/d29bf364bd292c78cf774a5c37a791db

#### sudo apt install fonts-cantarell fonts-cascadia-code ttf-ubuntu-font-family -y

#### wget $url_google_fonts

#### tar -zxvf main.tar.gz

#### sudo mkdir -p /usr/share/fonts/truetype/google-fonts

#### ls

#### ls fonts-main/

#### find $PWD/fonts-main/ -name "\*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/

#### find $PWD/fonts-main/ -name "\*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;

#### cd ..

#### rm -rf fonts/

#### fc-cache -f
