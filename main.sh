#!/bin/bash

. ./program_installer.sh
. ./utils_installer.sh

# Códigos de color ANSI
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar el menú
show_menu() {
    clear
    echo "==========================================="
    echo "      Menú de Instalación de Apps"
    echo "==========================================="
    echo "      Docker Compose installer"
    echo "==========================================="
    echo "1. ----------------"
    echo "2. Instalar Docker and Portainer"
    echo "3. ----------------"
    echo "4. ----------------"
    echo "==========================================="
    echo "      Configurar parametros"
    echo "==========================================="
    echo "5. Configurar Nameservers y Hosts"
    echo "6. Instalar python y modificar alias"
    echo "7. Salir"
    echo "==========================================="
    echo -n "Por favor, elige una opción: "
}

# Bucle principal del menú
while true; do
    show_menu
    read -r option
    clear
    case $option in
        1) install_nginx ;;
        2) install_docker_portainer ;;
        3) install_git ;;
        4) install_vscode ;;
        5) configuring_nameserver_and_hosts ;;
        6) install_python_and_alias;;
        7) echo "Saliendo del menú. ¡Hasta luego!"; break ;;
        *) echo "Opción inválida. Por favor, intenta de nuevo." ; sleep 2 ;;
    esac
    echo ""
    echo "Presiona Enter para continuar..."
    read -r
done