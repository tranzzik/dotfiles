#!/usr/bin/bash

DOTFILES_DIR="/home/$(whoami)/dotfiles"

TRACKED_CONFIGS=("nvim" "neofetch" "dunst" "rofi" "picom" "polybar" "i3" "alacritty" "kitty")

if [ -d $DOTFILES_DIR ]; then
    cd $DOTFILES_DIR

    status=$(git status)

    if grep -q "nothing to commit" <<< $status; then
        echo "Everything up to date."
        exit 0
    fi

    cp /home/$(whoami)/.zshrc .

    for config in ${TRACKED_CONFIGS[@]}; do
        if [ -d "/home/$(whoami)/.config/$config" ]; then
            cp -r /home/$(whoami)/.config/$config .config/
        fi
    done

    git add .
    git commit -m "Auto commit, $(date)"
    git push

else
    cd /home/$(whoami)/
    git clone git@github.com:tranzzik/dotfiles.git
fi
