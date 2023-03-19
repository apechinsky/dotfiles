#!/bin/bash

alacrittyConfigFile=$HOME/.config/alacritty/alacritty.yml
themesDir=$HOME/.config/alacritty/themes/themes
currentThemeFile=$HOME/.config/alacritty/themes/theme.yaml

themeFile=$1

main() {

    if [[ -f $themeFile ]]; then
        setTheme "$themeFile"
    else

        originalTheme=$(grep "alacritty/themes" $alacrittyConfigFile | cut -d '-'  -f 2 | tr -d ' ')

        # themeFile=$(find "$themesDir" -name "*.yaml" | fzf )
        themeFile=$(find "$themesDir" -name "*.yaml" | \
            fzf --bind "focus:execute(~/.config/alacritty/alacritty-switch-theme.sh {})")

        if [[ -n $themeFile ]]; then
            setTheme "$themeFile"
        else
            setTheme "$originalTheme"
        fi
    fi
}

function setTheme() {
    local selectedTheme="$1"

    selectedTheme=$(readlink -f "$selectedTheme")

    sed -i "/alacritty\/themes/c\   - $selectedTheme" alacritty.yml
}

main "$@"
