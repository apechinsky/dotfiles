#!/bin/bash

alacrittyConfigFile=$HOME/.config/alacritty/alacritty.yml
themesDir=$HOME/.config/alacritty/themes/themes
currentThemeFile=$HOME/.config/alacritty/themes/theme.yaml


function switchTheme() {
    local selectedTheme="$1"

    echo "$date $selectedTheme" >> "$HOME/.config/alacritty/themes/test.log"

    if [[ -n $selectedTheme ]]; then
        rm -f "$currentThemeFile"
        ln -s "$selectedTheme" "$currentThemeFile"
        printf "#\n" >> "$alacrittyConfigFile"
    fi
}
export -f switchTheme

selectedTheme=$(find "$themesDir" -name "*.yaml" | fzf --bind "focus:execute(switchTheme {})")
