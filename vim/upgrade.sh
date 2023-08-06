#!/bin/sh

dir="$HOME/.vim/pack/vendor/start"

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Directory $dir not found!"
    exit 1
fi

# Traverse each directory and run the command
for subdir in "$dir"/*; do
    echo "Upgrading $subdir"
    if [ -d "$subdir" ] && [ -d "$subdir/.git" ]; then
        (cd "$subdir" && git pull --depth 1)
    fi
done

