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
    inst gnome-shell-extension-app-icons-taskbar
    inst gnome-shell-extension-appindicator
    inst gnome-shell-extension-simple-system-monitor
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
}

# games
minecraft() {
    inst prismlauncher-qt5-bin
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
dig() {
    inst bind-tools
}

nmap() {
    inst nmap
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
    ask "Configure gnome" gnome
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
    ask "Install dig" dig
    ask "Install nmap" nmap
    ask "Install filezilla" filezilla
    ask "Install vscode" vscode
    ask "Install wine" wine
    ask "Install wireguard" wireguard
}

ask "Global category" global
ask "Games category" games
ask "Office category" office
ask "Advanced category" advanced