echo "Automatic setup script  Arch , Fedora , Ubuntu 24.04"

#!/usr/bin/env bash

if command -v apt >/dev/null 2>&1; then
    
    sudo apt update
    sudo apt upgrade -y

    sudo snap remove firefox 
    sudo snap autoremove

    sudo apt autoremove -y
    sudo apt install -y flatpak zsh git go ubuntu-restricted-extras 

elif command -v dnf >/dev/null 2>&1; then

    sudo dnf update -y
    sudo dnf install -y firefox tree neovim neofetch flatpak zsh git go vlc

elif command -v pacman >/dev/null 2>&1; then

    sudo pacman -Syu --noconfirm fastfetch firefox tree neovim flatpak zsh go 

else
    echo "No supported package manager found"
    exit 1

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub org.mozilla.firefox
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub app.zen_browser.zen 

curl -f https://zed.dev/install.sh | sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # yes should be typed manually 

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

cat <<DATA > ~/.zshrc 

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
DATA

if command -v apt >/dev/null 2>&1; then
    
    locale  # check for UTF-8
    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
    locale  # verify settings

    sudo apt install software-properties-common
    sudo add-apt-repository universe

    sudo apt update && sudo apt install curl -y

    export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
    
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
    
    sudo dpkg -i /tmp/ros2-apt-source.deb
    sudo apt update && sudo apt install ros-dev-tools #optional

    sudo apt update
    sudo apt upgrade 

    sudo apt install ros-jazzy-desktop
    
    source /opt/ros/jazzy/setup.zsh

if command -v dnf >/dev/null 2>&1; then

    # docker installation script will be included in the future --need-help

if command -v pacman >dev/null 2>&1; then 

    # dokcer installation script will be included in the future --need-help

# Things to be added  
    # Manual type of yes in oh-my-zsh
    # ROS2 docker installation script for Arch and Fedora 
    # Multimedia codecs (non-free H.265 H.264)


