#!/usr/bin/env bash

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