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

# Función para verificar e instalar Docker si no está presente
check_and_install_docker() {
    echo -e "${BLUE}Verificando instalación de Docker...${NC}"
    if command -v docker &> /dev/null; then
        echo -e "✅ ${GREEN}Docker ya está instalado.${NC}"
    else
        echo -e "ℹ️ ${BLUE}Docker no está instalado. Procediendo con la instalación...${NC}"
        install_docker_portainer
        check_command_status "Instalación de Docker"
    fi
}


check_env_exist(){
    # Verificar si el archivo .env ya existe
if [ -f "$1" ]; then
    echo -e "${RED}El archivo $1 ya existe. Eliminando ${NC}"
    rm -rf "$1"
    check_command_status "Eliminación del archivo .env existente"
else
    echo "# Variables de entorno generadas automáticamente" > "$1"
    check_command_status "El archivo $1 no existe. Creando uno nuevo"
    
    # Si no quieres sobrescribir, puedes salir con un error:
    # exit 1
fi
}

############################################################################################################################################
                                                # INSTALADORES DE PROGRAMAS Y CONTENEDORES
############################################################################################################################################

# Función para instalar Docker y Portainer
install_docker_portainer() {
    echo "================================================="
    echo "Instalando Docker..."
    echo "================================================="
    echo ""
    sudo apt update > /dev/null 2>&1
    check_command_status "1/8 Actualización de apt"
    sudo apt-get install ca-certificates curl -y > /dev/null 2>&1
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
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y #> /dev/null 2>&1
    check_command_status "8/8 Instalación de Docker"
    echo "================================================="
    echo "Instalando Portainer..."
    echo "================================================="
    sudo docker volume create portainer_data > /dev/null 2>&1
    check_command_status "1/2 Creación de volumen de Portainer"
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts > /dev/null 2>&1
    check_command_status "2/2 Instalación de Portainer"
    echo -e "✅ ${GREEN}Docker y Portainer instalados correctamente.${NC}"
    echo -e "${BLUE}Accede a Portainer en https://localhost:9443${NC}"


}


# Función para instalar VS Code
install_postgressql() {
    echo "================================================="
    echo "Instalando PostgreSQL..."
    echo "================================================="
    echo ""
    cd ./compose/postgressql || exit 1
    ##################################################
    #DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
    ENV_FILE=".env"
    
    if [ -n "$1" ] && [ -n "$2" ]&& [ -n "$3" ]; then
        red_name="$1"
        CONTAINER_NAME="$2"
        DB_PASSWORD="$3"
        echo -e "✅ ${GREEN}Usando variables pasadas: Red='$red_name', CONTAINER_NAME='$CONTAINER_NAME'${NC}"
    else
        DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
        echo -e "${BLUE}Escribe el nombre que tendra la red en docker${NC}"
        read -p "Nombre: " red_name
        CONTAINER_NAME="DB_POSTGRESQL"
    fi
    ##################################################
    check_env_exist "$ENV_FILE"
    echo "CONTAINER_NAME=$CONTAINER_NAME" >> "$ENV_FILE"
    echo "RED_NAME=$red_name" >> "$ENV_FILE"
    echo "DB_PASSWORD=$DB_PASSWORD" >> "$ENV_FILE"
    
    check_and_install_docker
    
    docker network create "$red_name" > /dev/null 2>&1
    sleep 2
    check_command_status "1/3 Creación de red de docker: $red_name"
    docker compose up -d > /dev/null 2>&1
    check_command_status "2/3 Instalación de PostgresSQL"
    docker network connect "$red_name" $CONTAINER_NAME > /dev/null 2>&1
    check_command_status "3/3 Conectando $CONTAINER_NAME a la red: $red_name"
    cd ../..
    echo "postgressql instalado."
}

# Función para verificar y clonar el repositorio
install_redisdb() {
    echo "================================================="
    echo "Instalando Redis..."
    echo "================================================="
    echo ""
    cd ./compose/redis || exit 1
    
    ###################################################
    ENV_FILE=".env"
    
    if [ -n "$1" ] && [ -n "$2" ]; then
        red_name="$1"
        CONTAINER_NAME="$2"
        echo -e "✅ ${GREEN}Usando variables pasadas: Red='$red_name', NAME_CONTAINER='$CONTAINER_NAME'${NC}"
    else
        DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
        echo -e "${BLUE}Escribe el nombre que tendra la red en docker${NC}"
        read -p "Nombre: " red_name
        CONTAINER_NAME="DB_REDIS"
    fi
    ##################################################
    check_env_exist "$ENV_FILE"
    echo "CONTAINER_NAME=$CONTAINER_NAME" >> "$ENV_FILE"
    echo "RED_NAME=$red_name" >> "$ENV_FILE"
    check_and_install_docker

    docker network create "$red_name" > /dev/null 2>&1
    sleep 2
    check_command_status "1/3 Creación de red de docker: $red_name"
    docker compose up -d > /dev/null 2>&1
    check_command_status "2/3 Instalación de RedisDB"
    sleep 2
    docker network connect "$red_name" $CONTAINER_NAME #> /dev/null 2>&1
    check_command_status "3/3 Conectando $CONTAINER_NAME a la red: $red_name"
    cd ../..
    echo "redisdb instalado."
}

install_n8n() {
    echo "================================================="
    echo "Instalando N8N..."
    echo "================================================="
    echo ""
    
    #Creacion variable de entorno
    DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
    N8N_ENCRYPTION_KEY=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)  

    echo -e "${BLUE}Escribe el dominio o ip para el n8n ej:(n8n.conext.net.ve o 181.232.180.1)${NC}"
    read -p "dominio o ip: " URL  
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe si es http o https${NC}"
    read -p "tipo de ssl: " SSL 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el nombre del proyecto ej:(n8n_chatboot)${NC}"
    read -p "Nombre: " PROJECT_NAME  
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el correo SMTP${NC}"
    read -p "Correo: " SMTP_CORREO 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe la clave del SMTP${NC}"
    read -p "Clave: " SMTP_PASS 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el nombre que tendra la red en docker${NC}"
    read -p "Nombre: " red_name

    cd ./compose/n8n || exit 1
    CONTAINER_MAYUSCULES=$(echo "$PROJECT_NAME" | tr '[:lower:]' '[:upper:]')
    CONTAINER_NAME_N8N="${CONTAINER_MAYUSCULES}_N8N"
    ENV_FILE=".env"
    check_env_exist "$ENV_FILE"
    echo "DB_PASSWORD=$DB_PASSWORD" >> "$ENV_FILE"
    echo "N8N_ENCRYPTION_KEY=$N8N_ENCRYPTION_KEY" >> "$ENV_FILE"
    echo "URL=$URL" >> "$ENV_FILE"
    echo "SSL=$SSL" >> "$ENV_FILE"
    echo "SMTP_CORREO=$SMTP_CORREO" >> "$ENV_FILE"
    echo "SMTP_PASS=$SMTP_PASS" >> "$ENV_FILE"
    echo "CONTAINER_NAME=$CONTAINER_NAME_N8N" >> "$ENV_FILE"

    cd ../..

    install_postgressql "$red_name" "${CONTAINER_NAME_N8N}_DB_POSTGRESQL" "$DB_PASSWORD"    
    install_redisdb "$red_name" "${CONTAINER_NAME_N8N}_DB_REDIS"
    check_and_install_docker
    cd ./compose/n8n || exit 1

    echo " nombre de container ${CONTAINER_NAME_N8N}"
    docker compose up -d > /dev/null 2>&1
    check_command_status "1/4 Instalación de N8N"
    docker network connect "$red_name" "${CONTAINER_NAME_N8N}_MAIN" #> /dev/null 2>&1
    check_command_status "2/4 Conectando $CONTAINER_NAME_N8N a la red: $red_name"
    docker network connect "$red_name" "${CONTAINER_NAME_N8N}_WEBHOOK" #> /dev/null 2>&1
    check_command_status "3/4 Conectando $CONTAINER_NAME_N8N a la red: $red_name"
    docker network connect "$red_name" "${CONTAINER_NAME_N8N}_WORKER" #> /dev/null 2>&1
    check_command_status "4/4 Conectando $CONTAINER_NAME_N8N a la red: $red_name"
    cd ../..

    echo "N8N instalado."
}

# Función para instalar PGVector
install_pgvector() {
    echo "================================================="
    echo "Instalando PGVector..."
    echo "================================================="
    echo ""
    cd ./compose/pgvector || exit 1
    ##################################################
    ENV_FILE=".env"
    
    if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ]; then
        red_name="$1"
        CONTAINER_NAME="$2"
        DB_PASSWORD="$3"
        echo -e "✅ ${GREEN}Usando variables pasadas: Red='$red_name', CONTAINER_NAME='$CONTAINER_NAME'${NC}"
    else
        DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
        echo -e "${BLUE}Escribe el nombre que tendra la red en docker${NC}"
        read -p "Nombre: " red_name
        CONTAINER_NAME="DB_PGVECTOR"
    fi
    ##################################################
    check_env_exist "$ENV_FILE"
    echo "CONTAINER_NAME=$CONTAINER_NAME" >> "$ENV_FILE"
    echo "RED_NAME=$red_name" >> "$ENV_FILE"
    echo "DB_PASSWORD=$DB_PASSWORD" >> "$ENV_FILE"
    
    check_and_install_docker
    
    docker network create "$red_name" > /dev/null 2>&1
    sleep 2
    check_command_status "1/3 Creación de red de docker: $red_name"
    docker compose up -d > /dev/null 2>&1
    check_command_status "2/3 Instalación de PGVector"
    docker network connect "$red_name" $CONTAINER_NAME > /dev/null 2>&1
    check_command_status "3/3 Conectando $CONTAINER_NAME a la red: $red_name"
    cd ../..
    echo "PGVector instalado."
}

install_chatwoot() {
    echo "================================================="
    echo "Instalando CHATWOOT..."
    echo "================================================="
    echo ""
    
    #Creacion variable de entorno
    DB_POSTGRES_PASSWORD=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 32)
    SECRET_KEY_BASE=$(cat /dev/urandom | tr -dc 'a-z0-9' | head -c 40)  

    echo -e "${BLUE}Escribe el dominio o ip para el n8n ej:(n8n.conext.net.ve o 181.232.180.1)${NC}"
    read -p "dominio o ip: " URL  
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe si es http o https${NC}"
    read -p "tipo de ssl: " SSL 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el nombre del proyecto ej:(n8n_chatboot)${NC}"
    read -p "Nombre: " PROJECT_NAME  
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el correo SMTP${NC}"
    read -p "Correo: " SMTP_CORREO 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe la clave del SMTP${NC}"
    read -p "Clave: " SMTP_PASS 
    #-------------------------------------------------------------
    echo -e "${BLUE}Escribe el nombre que tendra la red en docker${NC}"
    read -p "Nombre: " red_name

    cd ./compose/chatwoot || exit 1
    CONTAINER_MAYUSCULES=$(echo "$PROJECT_NAME" | tr '[:lower:]' '[:upper:]')
    CONTAINER_NAME_CHATWOOT="${CONTAINER_MAYUSCULES}_CHATWOOT"
    ENV_FILE=".env"
    check_env_exist "$ENV_FILE"
    echo "DB_POSTGRES_PASSWORD=$DB_POSTGRES_PASSWORD" >> "$ENV_FILE"
    echo "SECRET_KEY_BASE=$SECRET_KEY_BASE" >> "$ENV_FILE"
    echo "URL=$URL" >> "$ENV_FILE"
    echo "SSL=$SSL" >> "$ENV_FILE"
    echo "SMTP_CORREO=$SMTP_CORREO" >> "$ENV_FILE"
    echo "SMTP_PASS=$SMTP_PASS" >> "$ENV_FILE"
    echo "CONTAINER_NAME=$CONTAINER_NAME_CHATWOOT" >> "$ENV_FILE"
    echo "RED_NAME=$red_name" >> "$ENV_FILE"

    cd ../..
}