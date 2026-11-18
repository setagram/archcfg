#!/bin/bash

echo "welcome"
echo "read documentation (https://github.com/setagram/archcfg)"

if [ "$EUID" -eq 0 ]; then
  echo "error: don't launch this with sudo/root"
  exit 1
fi

read -p "start? [Y/n] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
    echo "exit"
    exit 0
fi

echo "starting ..."

echo "requesting sudo privileges ..."
sudo -v || exit 1

if ! command -v flatpak &> /dev/null; then
    echo "installing flatpak ..."
    sudo pacman -S --noconfirm flatpak
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

read -p "install ayugram? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "installing ayugram ..."
    curl -fL https://github.com/0FL01/AyuGramDesktop-flatpak/releases/latest/download/ayugram-desktop.flatpak -o /tmp/ayugram.flatpak && \
        sudo flatpak install --noninteractive /tmp/ayugram.flatpak || echo "AyuGram install failed, skipping"
fi

read -p "install discord? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "installing discord ..."
    sudo flatpak install --noninteractive flathub com.discordapp.Discord || echo "Discord install failed, skipping"
fi

read -p "install spotify? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "installing spotify ..."
    sudo flatpak install --noninteractive flathub com.spotify.Client || echo "Spotify install failed, skipping"
fi

read -p "install vs code? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "installing vs code ..."
    sudo flatpak install --noninteractive flathub com.visualstudio.code || echo "VS Code install failed, skipping"
fi

read -p "install happ? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "installing happ ..."
    if curl -fL https://github.com/Happ-proxy/happ-desktop/releases/latest/download/Happ.linux.x64.pkg.tar.zst -o /tmp/happ.pkg.tar.zst; then
        sudo pacman -U --noconfirm /tmp/happ.pkg.tar.zst
    else
        echo "Happ download failed, skipping"
    fi
fi

echo "launching serpantinum ..."

curl -fsSL install.serpantinum.dev | sh

echo "done."
