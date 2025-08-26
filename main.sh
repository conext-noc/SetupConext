#!/bin/bash

# Códigos de color ANSI
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

check_and_clone_repo() {
    echo -e "${BLUE}Verificando si el repositorio SetupConext existe...${NC}"
    if [ -d "SetupConext" ]; then
        echo -e "✅ ${GREEN}El repositorio SetupConext ya existe.${NC}"
    else
        echo -e "${BLUE}El repositorio SetupConext no existe. Clonando la rama dev...${NC}"
        git clone -b dev https://github.com/conext-noc/SetupConext.git > /dev/null 2>&1
        check_command_status "Clonación del repositorio SetupConext (rama dev)"
    fi
}
#check_and_clone_repo

cd ./SetupConext || { echo -e "${RED}Error: No se pudo cambiar al directorio SetupConext.${NC}"; exit 1; }

. ./program_installer.sh
. ./utils_installer.sh

#check_and_clone_repo

# Función para mostrar el menú
show_menu() {
    clear
    echo "==========================================="
    echo "      Menú de Instalación de Apps"
    echo "==========================================="
    echo "      Docker Compose installer"
    echo "==========================================="
    echo "1. Instalar PostgrestSQL"
    echo "2. Instalar Docker and Portainer"
    echo "3. Instalar N8N"
    echo "4. Instalar Redis DB"
    echo "5. Instalar PGVector"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "==========================================="
    echo "      Configurar parametros"
    echo "==========================================="
    echo "13. Configurar Nameservers y Hosts"
    echo "14. Instalar python y modificar alias"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "---------------------"
    echo "20. Salir"
    echo "==========================================="
    echo -n "Por favor, elige una opción: "
}

# Bucle principal del menú
while true; do
    show_menu
    read -r option
    clear
    case $option in
        1) install_postgressql ;;
        2) install_docker_portainer ;;
        3) install_n8n ;;
        4) install_redisdb ;;
        #====================================================================
        13) configuring_nameserver_and_hosts ;;
        14) install_python_and_alias;;
        15) echo "Saliendo del menú. ¡Hasta luego!"; break ;;
        *) echo "Opción inválida. Por favor, intenta de nuevo." ; sleep 2 ;;
    esac
    echo ""
    echo "Presiona Enter para continuar..."
    read -r
done
