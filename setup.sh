#!/bin/bash

inst() {
    paru --skipreview --noconfirm -S $1
}

# paru
installer() {
    cd /tmp
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/paru-bin.tar.gz -O - | tar -xz
    cd paru-bin
    makepkg -si
    cd
    rm -rf /tmp/paru-bin
}

# gnome
gnome() {
    gnome-extensions enable system-monitor@gnome-shell-extensions.gcampax.github.com
    inst gnome-shell-extension-app-icons-taskbar
    gnome-extensions enable aztaskbar@aztaskbar.gitlab.com
    inst gnome-shell-extension-appindicator
    gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
}

# bluetooth
bluetooth() {
    inst bluez
    inst bluez-utils
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

gnome-config() {
    gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface enable-hot-corners false
    gsettings set org.gnome.desktop.interface clock-show-seconds true
    gsettings set org.gnome.desktop.interface clock-show-weekday true
    gsettings set org.gnome.desktop.calendar show-weekdate true
    gsettings set org.gnome.desktop.interface clock-format 24h
}

# games
minecraft() {
    inst prismlauncher
}

epicgames() {
    inst heroic-games-launcher-bin
}

steam() {
    inst steam
}

bottles() {
    inst bottles
}

# office
onlyoffice() {
    inst onlyoffice-bin
}

firefox() {
    inst firefox
}

chromium() {
    inst chromium
}

spotify() {
    inst spotify
}

discord() {
    inst discord
}

# advanced
docker() {
    inst docker
    inst docker-compose
    sudo usermod -aG docker $USER
}

dig() {
    inst bind-tools
}

nmap() {
    inst nmap
}

nload() {
    inst nload
}

ncdu() {
    inst ncdu
}

filezilla() {
    inst filezilla
}

vscode() {
    inst code
}

wine() {
    inst wine
    inst wine-gecko
    inst wine-mono
    inst winetricks
}

wireguard() {
    inst wireguard-tools
}

ask() {
    local func="$2"
    while true; do
        read -n 1 -p "$1 ? (y/n) " yn
        echo
        case $yn in 
            [yY] ) "$func";
                break;;
            [nN] ) break;;
            * ) echo invalid response;;
        esac
    done
}

# categories

global() {
    ask "Install paru" installer
    ask "Install gnome extensions" gnome
    ask "Configure bluetooth" bluetooth
    ask "Configure gnome" gnome-config
}

games() {
    inst gamemode
    inst lib32-gamemode
    inst gamescope
    ask "Install minecraft" minecraft
    ask "Install epicgames" epicgames
    ask "Install steam" steam
    ask "Install bottles (battlenet, origin, etc)" bottles
}

office() {
    ask "Install onlyoffice" onlyoffice
    ask "Install chromium" chromium
    ask "Install firefox" firefox
    ask "Install spotify" spotify
    ask "Install discord" discord
}

advanced() {
    ask "Install docker" docker
    ask "Install dig" dig
    ask "Install nmap" nmap
    ask "Install ncdu" ncdu
    ask "Install nload" nload
    ask "Install filezilla" filezilla
    ask "Install vscode" vscode
    ask "Install wine" wine
    ask "Install wireguard" wireguard
}

ask "Global category" global
ask "Games category" games
ask "Office category" office
ask "Advanced category" advanced
