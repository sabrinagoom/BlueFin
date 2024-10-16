#!/bin/bash

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

run_installer() {
    local distro=$1

    case "$distro" in
        ubuntu)
            echo -e "\e[1;100m####     Detected Ubuntu-based system\e[0m"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/installer/ubuntu.sh"
            ;;
        debian)
            echo -e "\e[1;100m####     Detected Debian-based system\e[0m"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/installer/debian.sh"
            ;;    
        rocky|rhel|almalinux|centos)
            $distro="rhel"
            echo -e "\e[1;100m####     Detected RHEL-based system\e[0m"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/installer/rhel.sh"
            ;;
        *)
            echo -e "\e[1;100m####     This Linux distribution ('$distro') is unsupported by both BlueFin and Pterodactyl Wings\e[0m"
            exit 1
            ;;
    esac

    echo -e "\e[1;100m####     Downloading and executing BlueFin installer\e[0m"
    wget "$INSTALLER_URL"
    chmod +x $distro.sh
    sudo ./$distro.sh
}

distro=$(detect_distro)
run_installer "$distro"
