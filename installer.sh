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
            echo "Detected Ubuntu-based system"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/ubuntu_installer.sh"
            ;;
        debian)
            echo "Detected Debian-based system"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/debian_installer.sh"
            ;;    
        rocky|rhel|almalinux|centos)
            echo "Detected RHEL-based system"
            INSTALLER_URL="https://raw.githubusercontent.com/sabrinagoom/BlueFin/refs/heads/main/rhel_installer.sh"
            ;;
        *)
            echo "This Linux distribution ('$distro') is unsupported by both BlueFin and Pterodactyl Wings"
            exit 1
            ;;
    esac

    echo "Downloading and executing BlueFin installer"
    curl -sSL "$INSTALLER_URL" | bash
}

distro=$(detect_distro)
run_installer "$distro"
