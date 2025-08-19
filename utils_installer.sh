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
configuring_nameserver_and_hosts() {
    echo -e "${BLUE}Configurando nameserver y hosts...${NC}"

    # Verificar y agregar nameservers si no existen
    if ! grep -q "nameserver 8.8.8.8" /etc/resolv.conf; then
        echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf > /dev/null
        check_command_status "Agregar nameserver 8.8.8.8"
    else
        echo -e "✅ ${GREEN}Nameserver 8.8.8.8 ya existe.${NC}"
    fi

    if ! grep -q "nameserver 8.8.4.4" /etc/resolv.conf; then
        echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf > /dev/null
        check_command_status "Agregar nameserver 8.8.4.4"
    else
        echo -e "✅ ${GREEN}Nameserver 8.8.4.4 ya existe.${NC}"
    fi

    # Preguntar sobre la restricción de IPs
    echo -e "${BLUE}¿Quieres restringir o permitir IPs? Opciones:(restringir/permitir/no)${NC}"
    read -p "Tu elección: " ip_choice

    if [[ "$ip_choice" == "restringir" ]]; then
        echo -e "${BLUE}Ingresa las IPs que quieres DENegar (separadas por espacio):${NC}"
        read -p "IPs a denegar: " deny_ips
        for ip in $deny_ips; do
            sudo iptables -A INPUT -s "$ip" -j DROP
            check_command_status "Denegar IP: $ip"
        done
        echo -e "✅ ${GREEN}Reglas de denegación de IPs aplicadas.${NC}"
    elif [[ "$ip_choice" == "permitir" ]]; then
        echo -e "${BLUE}Ingresa las IPs que quieres PERMITIR (separadas por espacio):${NC}"
        read -p "IPs a permitir: " allow_ips
        for ip in $allow_ips; do
            sudo iptables -A INPUT -s "$ip" -j ACCEPT
            check_command_status "Permitir IP: $ip"
        done
        echo -e "${BLUE}¿Quieres denegar todas las demás IPs o solo algunas? Opciones:(todas/algunas/no)${NC}"
        read -p "Tu elección: " deny_other_choice
        if [[ "$deny_other_choice" == "todas" ]]; then
            sudo iptables -P INPUT DROP
            check_command_status "Denegar todas las demás IPs"
            echo -e "✅ ${GREEN}Política de INPUT por defecto establecida a DROP.${NC}"
        elif [[ "$deny_other_choice" == "algunas" ]]; then
            echo -e "${BLUE}Ingresa las IPs adicionales que quieres DENegar (separadas por espacio):${NC}"
            read -p "IPs adicionales a denegar: " additional_deny_ips
            for ip in $additional_deny_ips; do
                sudo iptables -A INPUT -s "$ip" -j DROP
                check_command_status "Denegar IP adicional: $ip"
            done
            echo -e "✅ ${GREEN}Reglas de denegación de IPs adicionales aplicadas.${NC}"
        fi
    else
        echo -e "ℹ️ ${BLUE}No se aplicarán restricciones de IP.${NC}"
    fi

    echo -e "✅ ${GREEN}Configuración de nameserver y hosts completada.${NC}"
}

# Función para instalar Python y cambiar el sufijo
install_python_and_alias() {
    echo -e "${BLUE}Instalando Python y configurando alias...${NC}"

    sudo apt update > /dev/null 2>&1
    check_command_status "Actualización de apt para Python"

    sudo apt install python3 python3-pip -y > /dev/null 2>&1
    check_command_status "Instalación de Python3 y pip3"

    # # Crear un alias para 'python' apuntando a 'python3'
    # if [ ! -f "/usr/local/bin/python" ]; then
    #     sudo ln -s /usr/bin/python3 /usr/local/bin/python
    #     check_command_status "Crear alias 'python' para 'python3'"
    # else
    #     echo -e "✅ ${GREEN}Alias 'python' ya existe.${NC}"
    # fi

    # # Crear un alias para 'pip' apuntando a 'pip3'
    # if [ ! -f "/usr/local/bin/pip" ]; then
    #     sudo ln -s /usr/bin/pip3 /usr/local/bin/pip
    #     check_command_status "Crear alias 'pip' para 'pip3'"
    # else
    #     echo -e "✅ ${GREEN}Alias 'pip' ya existe.${NC}"
    # fi

    echo -e "✅ ${GREEN}Instalación de Python completada.${NC}"
}
