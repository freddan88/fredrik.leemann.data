#!/usr/bin/env bash

url_home_templates="https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/templates.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

dir_home_templates=$(xdg-user-dir TEMPLATES)

cd "$dir_home_templates" && wget "$url_home_templates"
cd "$dir_home_templates" && unzip -o templates.zip
cd "$dir_home_templates" && rm -f templates.zip

echo " "
echo "DOWNLOADING AND INSTALLING TEMPLATES FOR THE FILEBROWSER"
echo " "

ls -al "$dir_home_templates"
