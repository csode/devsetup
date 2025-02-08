#!/bin/bash

echo "Welcome to the application installer"
echo "Do you wish to continue"

read -p "Enter 1 to contine any key else to exit " num

if [ $num == 1 ]; then
    sudo pacman -Syu
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    if ! pacman -Q fzf &>/dev/null; then
        sudo pacman -S --noconfirm fzf
    fi
    if ! pacman -Q xorg-xrandr &>/dev/null; then
        sudo pacman -S --noconfirm xorg-xrandr
    fi
    if ! pacman -Q feh &>/dev/null; then
        sudo pacman -S --noconfirm feh
    fi
    if ! pacman -Q rofi &>/dev/null; then
        sudo pacman -S --noconfirm rofi
    fi
    if ! pacman -Q polyabr &>/dev/null; then
        sudo pacman -S --noconfirm polybar
    fi
    if ! pacman -Q neovim &>/dev/null; then

        sudo pacman -S --noconfirm neovim
    fi
    if ! pacman -Q neofetch &>/dev/null; then
        sudo pacman -S --noconfirm neofetch
    fi
    if ! pacman -Q tilix &>/dev/null; then
        sudo pacman -S --noconfirm tilix
    fi
    if ! pacman -Q gimp &>/dev/null; then
        sudo pacman -S --noconfirm gimp
    fi
    if ! pacman -Q firefox >&/dev/null; then
        sudo pacman -S --noconfirm firefox
    fi
    if ! pacman -Q zsh; then
        sudo pacman -S --noconfirm zsh
    fi
    if ! pacman -Q i3-wm; then
        sudo pacman -S --noconfirm i3-wm
    fi
    if ! pacman -Q sddm; then
        sudo pacman -S --noconfirm sddm
    fi

    yay -S --noconfirm ttf-font-awesome
    yay -S --noconfirm ttf-fira-code
else
    echo "Not choosen"
fi

echo "Do you want my cofig files"
read -p "Enter 1 to contiue" option

if [ "$option" == "1" ]; then
    cp -r * ~/.config/
    cp -r .tmux.conf ~/
    echo "Copying Complete"
else
    echo "Not choosen"
fi
echo "Do you want my zsh"
read -p "Enter 1 to contiue" option
if [ "$option" = "1" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Not selcted"
fi
cp -r .zshrc ~/

if [ -d "$HOME/scripts" ]; then
    echo "Updating existing scripts repository..."
    cd "$HOME/scripts"
    git fetch --all
else
    echo "Cloning scripts repository..."
    git clone https://github.com/fedoralife/scripts.git "$HOME/scripts"
fi
