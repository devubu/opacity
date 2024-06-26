#!/bin/bash

show_help() {
    echo "This script toggles the opacity value in alacritty.yml and alacritty.toml between 0.95 and 1."
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -h, -help     Show this help message"
}

toggle_opacity() {
    local file_path=$1
    local current_opacity
    local new_opacity

    if [[ "$file_path" == *.yml ]]; then
        current_opacity=$(grep -o 'opacity: [0-9.]*' "$file_path" | awk '{print $2}')
    elif [[ "$file_path" == *.toml ]]; then
        current_opacity=$(grep -o 'opacity = [0-9.]*' "$file_path" | awk '{print $3}')
    else
        echo "Error: Unsupported file format $file_path."
        return
    fi

    if [ "$current_opacity" == "0.95" ]; then
        new_opacity="1.00"
    elif [ "$current_opacity" == "1.00" ]; then
        new_opacity="0.95"
    else
        echo "Error: Unable to determine current opacity value in $file_path."
        return
    fi

    if [[ "$file_path" == *.yml ]]; then
        sed -i "s/opacity: $current_opacity/opacity: $new_opacity/" "$file_path"
    elif [[ "$file_path" == *.toml ]]; then
        sed -i "s/opacity = $current_opacity/opacity = $new_opacity/" "$file_path"
    fi

    # echo "Successfully modified $file_path (toggled opacity to $new_opacity)"
}

if [ "$1" == "-h" ] || [ "$1" == "-help" ]; then
    show_help
    exit 0
fi

yml_path="$HOME/.config/alacritty/alacritty.yml"
toml_path="$HOME/.config/alacritty/alacritty.toml"

if [ -e "$yml_path" ]; then
    toggle_opacity "$yml_path"
fi

if [ -e "$toml_path" ]; then
    toggle_opacity "$toml_path"
fi

if [ ! -e "$yml_path" ] && [ ! -e "$toml_path" ]; then
    echo "Error: Neither alacritty.yml nor alacritty.toml found in $HOME/.config/alacritty"
fi
