#!/bin/bash

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

## Cores
amarelo="\e[33m"
verde="\e[32m"
branco="\e[97m"
bege="\e[93m"
vermelho="\e[91m"
reset="\e[0m"

version="2.6.3"

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

sudo apt update

sudo apt upgrade -y

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

aviso_aviso(){

clear
echo ""
echo -e "$amarelo===================================================================================================$reset"
echo -e "$amarelo=                                                                                                 $amarelo=$reset"
echo -e "$amarelo=                     $branco  █████╗     ██╗   ██╗    ██╗    ███████╗     ██████╗                       $amarelo=$reset"
echo -e "$amarelo=                     $branco ██╔══██╗    ██║   ██║    ██║    ██╔════╝    ██╔═══██╗                      $amarelo=$reset"
echo -e "$amarelo=                     $branco ███████║    ██║   ██║    ██║    ███████╗    ██║   ██║                      $amarelo=$reset"
echo -e "$amarelo=                     $branco ██╔══██║    ╚██╗ ██╔╝    ██║    ╚════██║    ██║   ██║                      $amarelo=$reset"
echo -e "$amarelo=                     $branco ██║  ██║     ╚████╔╝     ██║    ███████║    ╚██████╔╝                      $amarelo=$reset"
echo -e "$amarelo=                     $branco ╚═╝  ╚═╝      ╚═══╝      ╚═╝    ╚══════╝     ╚═════╝                       $amarelo=$reset"
echo -e "$amarelo=                                                                                                 $amarelo=$reset"
echo -e "$amarelo===================================================================================================$reset"
echo ""
echo ""
}

aviso_actualizando(){
    clear
    echo ""
    echo -e "$amarelo===================================================================================================$reset"
    echo -e "$amarelo=                                                                                                 $amarelo=$reset"
    echo -e "$amarelo=    $branco  █████╗  ██████╗████████╗██╗   ██╗ █████╗ ██╗     ██╗███████╗ █████╗ ███╗   ██╗██████╗  ██████╗     $amarelo=$reset"
    echo -e "$amarelo=    $branco ██╔══██╗██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗████╗  ██║██╔══██╗██╔═══██╗    $amarelo=$reset"
    echo -e "$amarelo=    $branco ███████║██║        ██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║██╔██╗ ██║██║  ██║██║   ██║    $amarelo=$reset"
    echo -e "$amarelo=    $branco ██╔══██║██║        ██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║██║╚██╗██║██║  ██║██║   ██║    $amarelo=$reset"
    echo -e "$amarelo=    $branco ██║  ██║╚██████╗   ██║   ╚██████╔╝██║  ██║███████╗██║███████╗██║  ██║██║ ╚████║██████╔╝╚██████╔╝    $amarelo=$reset"
    echo -e "$amarelo=    $branco ╚═╝  ╚═╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝     $amarelo=$reset"
    echo -e "$amarelo=                                                                                                 $amarelo=$reset"
    echo -e "$amarelo===================================================================================================$reset"
    echo ""
    echo ""
}
aviso_iniciando(){
    clear
    echo ""
    echo -e "$amarelo===================================================================================================$reset"
    echo -e "$amarelo=                                                                                                 $amarelo=$reset"
    echo -e "$amarelo=                  $branco ██╗███╗   ██╗██╗ ██████╗██╗ █████╗ ███╗   ██╗██████╗  ██████╗                 $amarelo=$reset"
    echo -e "$amarelo=                  $branco ██║████╗  ██║██║██╔════╝██║██╔══██╗████╗  ██║██╔══██╗██╔═══██╗                $amarelo=$reset"
    echo -e "$amarelo=                  $branco ██║██╔██╗ ██║██║██║     ██║███████║██╔██╗ ██║██║  ██║██║   ██║                $amarelo=$reset"
    echo -e "$amarelo=                  $branco ██║██║╚██╗██║██║██║     ██║██╔══██║██║╚██╗██║██║  ██║██║   ██║                $amarelo=$reset"
    echo -e "$amarelo=                  $branco ██║██║ ╚████║██║╚██████╗██║██║  ██║██║ ╚████║██████╔╝╚██████╔╝                $amarelo=$reset"
    echo -e "$amarelo=                  $branco ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝                 $amarelo=$reset"
    echo -e "$amarelo=                                              v. "$version"                                           $amarelo=$reset"
    echo -e "$amarelo===================================================================================================$reset"
    echo ""
    echo ""
}

aviso_verificando(){
    clear
    echo ""
    echo -e "$amarelo===================================================================================================$reset"
    echo -e "$amarelo=                                                                                                 $amarelo=$reset"
    echo -e "$amarelo=       $branco ██╗   ██╗███████╗██████╗ ██╗███████╗██╗ ██████╗ █████╗ ███╗   ██╗██████╗  ██████╗       $amarelo=$reset"
    echo -e "$amarelo=       $branco ██║   ██║██╔════╝██╔══██╗██║██╔════╝██║██╔════╝██╔══██╗████╗  ██║██╔══██╗██╔═══██╗      $amarelo=$reset"
    echo -e "$amarelo=       $branco ██║   ██║█████╗  ██████╔╝██║█████╗  ██║██║     ███████║██╔██╗ ██║██║  ██║██║   ██║      $amarelo=$reset"
    echo -e "$amarelo=       $branco ╚██╗ ██╔╝██╔══╝  ██╔══██╗██║██╔══╝  ██║██║     ██╔══██║██║╚██╗██║██║  ██║██║   ██║      $amarelo=$reset"
    echo -e "$amarelo=       $branco  ╚████╔╝ ███████╗██║  ██║██║██║     ██║╚██████╗██║  ██║██║ ╚████║██████╔╝╚██████╔╝      $amarelo=$reset"
    echo -e "$amarelo=       $branco   ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝       $amarelo=$reset"
    echo -e "$amarelo=                                                                                                 $amarelo=$reset"
    echo -e "$amarelo===================================================================================================$reset"
    echo ""
    echo ""
}
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         CONEXT DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

desc_ver(){
echo -e "                            Este script recomienda su uso en Ubuntu$amarelo 20.04$branco.$reset"
echo ""
} 

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

clear
aviso_verificando
echo "Espera mientras verificamos algunos datos."
sleep 1

# Verifica se está usando Ubuntu 20.04
if ! grep -q 'Ubuntu 20.04' /etc/os-release; then
    aviso_aviso
    desc_ver
    #echo "Este script recomenda o uso do Ubuntu 20.04."
    sleep 5
    clear
    aviso_verificando
fi

# Verifica se o usuário é root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root. Executando sudo su..."
    sudo su
fi

# Verifica se o usuário está no diretório /root/
if [ "$PWD" != "/root" ]; then
    echo "Mudando para o diretório /root/"
    cd /root || exit
fi

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##


aviso_iniciando 

## Fazendo upgrade
sudo apt upgrade -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "1/14 - [ OK ] - Actualizando"
else
    echo "1/14 - [ OFF ] - Actualizando"
fi

echo ""

## Instalando Sudo
apt install sudo -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "2/14 - [ OK ] - Verificando/Instalando sudo"
else
    echo "2/14 - [ OFF ] - Verificando/Instalando sudo"
fi

echo ""

## Instalando apt-utils
sudo apt-get install -y apt-utils > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "3/14 - [ OK ] - Verificando/Instalando apt-utils"
else
    echo "3/14 - [ OFF ] - Verificando/Instalando apt-utils"
fi

echo ""

## Instalando dialog
sudo apt-get install -y dialog > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "4/14 - [ OK ] - Verificando/Instalando dialog"
else
    echo "4/14 - [ OFF ] - Verificando/Instalando dialog"
fi

echo ""

## Instalando jq
sudo apt-get install -y jq > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "5/14 - [ OK ] - Verificando/Instalando jq 1/2"
else
    echo "5/14 - [ OFF ] - Verificando/Instalando jq 1/2"
fi

echo ""

## Instalando jq
sudo apt install jq -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "6/14 - [ OK ] - Verificando/Instalando jq 2/2"
else
    echo "6/14 - [ OFF ] - Verificando/Instalando jq 2/2"
fi

echo ""

## Instalando apache2-utils
sudo apt install apache2-utils -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "7/14 - [ OK ] - Verificando/Instalando apache2-utils 1/2"
else
    echo "7/14 - [ OFF ] - Verificando/Instalando apache2-utils1/2"
fi

echo ""

## Instalando apache2-utils
apt install apache2-utils -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "8/14 - [ OK ] - Verificando/Instalando apache2-utils 2/2"
else
    echo "8/14 - [ OFF ] - Verificando/Instalando apache2-utils 2/2"
fi

echo ""

## Instalando git
apt install git -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "9/14 - [ OK ] - Verificando/Instalando Git"
else
    echo "9/14 - [ OFF ] - Verificando/Instalando Git"
fi

echo ""

## Instalando python3
apt install python3 -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "10/14 - [ OK ] - Verificando/Instalando python3"
else
    echo "10/14 - [ OFF ] - Verificando/Instalando python3"
fi

echo ""

## Fazendo update
sudo apt update > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "11/14 - [ OK ] - Fazendo Update"
else
    echo "11/14 - [ OFF ] - Fazendo Update"
fi

echo ""

## Fazendo upgrade
sudo apt upgrade -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "12/14 - [ OK ] - Fazendo Upgrade"
else
    echo "12/14 - [ OFF ] - Fazendo Upgrade"
fi

echo ""

## Instalando neofetch
apt install neofetch -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "13/14 - [ OK ] - Verificando/Instalando neofetch"
else
    echo "13/14 - [ OFF ] - Verificando/Instalando neofetch"
fi

echo ""

# Verifica se o arquivo SetupOrion já existe
if [ -e "SetupConext" ]; then
    echo ""
    rm SetupConext
fi

# Baixa o script
curl -sSL https://raw.githubusercontent.com/conext-noc/SetupConext/main/core/SetupConext -o SetupConext
if [ $? -eq 0 ]; then
    echo "14/14 - [ OK ] - Ejecutando script"
    # Executa o script baixado
    cd /core
    chmod +x SetupOrion
    ./SetupOrion
else
    echo "14/14 - [ OFF ] - Ejecutando o script"
    echo "Cerrando Setup"
    sleep 5
fi


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
##                                         ORION DESIGN                                        ##
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

sudo apt update
sudo apt upgrade -y

clear
rm SetupConext