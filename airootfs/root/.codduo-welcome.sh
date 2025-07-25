#!/bin/bash

if [[ $(tty) == "/dev/tty1" ]] && [[ ! -f /tmp/codduo-welcome-shown ]]; then #Verifica se foi mandado a mensagem do TTT1 antes de dar boot
    clear
    echo -e "\033[35m  ██████╗ ██████╗ ██████╗ ██████╗ ██╗   ██╗ ██████╗ "
    echo -e "██╔════╝██╔═══██╗██╔══██╗██╔══██╗██║   ██║██╔═══██╗"
    echo -e "██║     ██║   ██║██║  ██║██║  ██║██║   ██║██║   ██║"
    echo -e "██║     ██║   ██║██║  ██║██║  ██║██║   ██║██║   ██║"
    echo -e "╚██████╗╚██████╔╝██████╔╝██████╔╝╚██████╔╝╚██████╔╝"
    echo -e " ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝\033[0m"
    echo ""
    echo -e "\033[36m        Sistema Minimalista para Baixo Consumo\033[0m"
    echo -e "\033[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo -e "Para instalar o \033[35mCODDUO OS\033[0m execute o comando:"
    echo -e "\033[33msudo /root/install.sh\033[0m"
    echo ""
    echo -e "Para conexão Wi-Fi, use o utilitário \033[35miwctl\033[0m"
    echo -e "Para conexão ethernet, o DHCP funcionará automaticamente"
    echo ""
    echo -e "\033[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    
    touch /tmp/codduo-welcome-shown
fi
