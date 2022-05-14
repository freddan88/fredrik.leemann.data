#!/usr/bin/env bash

i3_confid_file="$HOME/.config/i3/config"
i3_output_path="$HOME/.config/i3/docs/"

if [ -f "$i3_output_path/lock" ]; then exit; fi

echo " "
echo "GENERATING A NEW I3 KEYMAP CHEAT-SHEET IN HTML" && sleep 2

mkdir -p $i3_output_path
touch $i3_output_path/lock

i3_temp_variables_file="/tmp/i3variables.txt"
i3_temp_keybindings_file="/tmp/i3keybindings.txt"
cat $i3_confid_file | grep ^bindsym | cut -d" " -f2- >$i3_temp_keybindings_file
cat $i3_confid_file | grep ^set | cut -d" " -f2- >$i3_temp_variables_file

i3_output_markdown_file="$i3_output_path/i3keybindings.md"
i3_output_html_file="$i3_output_path/i3keybindings.html"
rm -f $i3_output_markdown_file

echo "<link rel='stylesheet' href='i3keybindings.css'>" >$i3_output_html_file
echo "<table class='i3-keybindings'>" >>$i3_output_html_file
echo "<thead>" >>$i3_output_html_file
echo "<tr>" >>$i3_output_html_file
echo "<th>Key:</th>" >>$i3_output_html_file
echo "<th>Command:</th>" >>$i3_output_html_file
echo "</tr>" >>$i3_output_html_file
echo "</thead>" >>$i3_output_html_file
echo "<tbody>" >>$i3_output_html_file

while read row; do
  keybinding=$(echo $row | cut -d" " -f1)
  keycommand=$(echo $row | cut -d" " -f2-)
  echo "<tr>" >>$i3_output_html_file
  echo "<td>$keybinding</td>" >>$i3_output_html_file
  echo "<td>$keycommand</td>" >>$i3_output_html_file
  echo "</tr>" >>$i3_output_html_file
done <$i3_temp_keybindings_file

echo "</tbody>" >>$i3_output_html_file
echo "</table>" >>$i3_output_html_file

echo "<div class='i3-variables'>" >>$i3_output_html_file
echo "<table>" >>$i3_output_html_file
echo "<thead>" >>$i3_output_html_file
echo "<tr>" >>$i3_output_html_file
echo "<th>Variable-name:</th>" >>$i3_output_html_file
echo "<th>Variable-value:</th>" >>$i3_output_html_file
echo "</tr>" >>$i3_output_html_file
echo "</thead>" >>$i3_output_html_file
echo "<tbody>" >>$i3_output_html_file

while read row; do
  name=$(echo $row | cut -d" " -f1)
  value=$(echo $row | cut -d" " -f2-)
  echo "<tr>" >>$i3_output_html_file
  echo "<td>$name</td>" >>$i3_output_html_file
  echo "<td>$value</td>" >>$i3_output_html_file
  echo "</tr>" >>$i3_output_html_file
done <$i3_temp_variables_file

echo "</tbody>" >>$i3_output_html_file
echo "</table>" >>$i3_output_html_file
echo "<p>Run: 'xmodmap' in terminal to find other modifier-keys like 'Mod4'</p>" >>$i3_output_html_file
echo "</div>" >>$i3_output_html_file

pandoc -s -r html $i3_output_html_file -o $i3_output_markdown_file

rm -f $i3_temp_keybindings_file
rm -f $i3_temp_variables_file
rm -f $i3_output_path/lock

if [[ "$1" == "-l" ]]; then
  cp -rf $i3_output_path $HOME
fi

echo "---------------------------------------------------------------------------"
echo "ADD '-l' AS AN ARGUMENT TO ALSO COPY GENERATED-FILES TO YOUR HOME-DIRECTORY"
echo " "
