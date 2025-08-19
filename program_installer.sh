#!/bin/bash

# Códigos de color ANSI
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Función para verificar el estado del último comando
check_command_status() {
    if [ $? -eq 0 ]; then
        echo -e "✅ ${GREEN}Éxito: $1 ${NC}"
    else
        echo -e "❌ ${RED}Error: $1 falló. ${NC}" >&2
        exit 1
    fi
}

# Función para instalar Nginx
install_nginx() {
    echo "Instalando Nginx..."
    # sudo apt update
    # check_command_status "Actualización de apt para Nginx"
    # sudo apt install nginx -y
    # check_command_status "Instalación de Nginx"
    echo "Nginx instalado."
}

# Función para instalar Docker y Portainer
install_docker_portainer() {
    echo "================================================="
    echo "Instalando Docker y Portainer..."
    echo "================================================="
    echo ""
    sudo apt update > /dev/null 2>&1
    check_command_status "1/8 Actualización de apt"
    sudo apt-get install ca-certificates curl > /dev/null 2>&1
    check_command_status "2/8 Instalacion curl y ca-certificates" 
    sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
    check_command_status "3/8Instalacion keyrings"
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
    check_command_status "4/8 Curl docker"
    sudo chmod a+r /etc/apt/keyrings/docker.asc > /dev/null 2>&1
    check_command_status "5/8 Chmod docker"
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    check_command_status "6/8 Añadir repositorio Docker"
    sudo apt update > /dev/null 2>&1
    check_command_status "7/8 Actualización de apt"
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null 2>&1
    check_command_status "8/8 Instalación de Docker"
   
}

# Función para instalar Git
install_git() {
    echo "Instalando Git..."
    # sudo apt update
    # check_command_status "Actualización de apt para Git"
    # sudo apt install git -y
    # check_command_status "Instalación de Git"
    # echo "Git instalado."
}

# Función para instalar VS Code
install_vscode() {
    echo "Instalando VS Code..."
    # sudo snap install --classic code
    # check_command_status "Instalación de VS Code"
    echo "VS Code instalado."
}