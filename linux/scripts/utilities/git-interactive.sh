#!/usr/bin/env bash
#
# THIS SCRIPT IS WORK IN PROGRESS

untracked_files=("$(git add -A -n | cut -d" " -f2 | xargs)")

for i in "${!untracked_files[@]}"; do
  echo "'${untracked_files[$i]}' $i" 'off' '\'
done

# selected_choices=$(dialog --no-shadow --output-fd 1 --checklist 'Files to include?' 30 60 10 \
# 'Apple' 1 'off' \
# 'Banana' 2 'off' \
# )

# clear

# echo "$selected_choices"

# LINKS
# https://linux.die.net/man/1/dialog
# https://linuxcommand.org/lc3_adv_dialog.php
# https://www.geeksforgeeks.org/creating-dialog-boxes-with-the-dialog-tool-in-linux
#
# dialog --checklist ‘checklist’ 30 60 60 ‘apple’ 5 ‘off’ ‘banana’ 2 ‘off’ ‘coco’ 3 ‘on’ ‘delta’ 4 ‘off’ 2> dialog.txt
# return_value=$?
#
# if $return_value = 0; then
#   cat dialog.txt
# fi
