#!/bin/bash

# CODDUO-OS Launcher
# Script para executar o menu CODDUO-OS manualmente

# Verificar se o sistema foi instalado corretamente
if [ ! -f "/usr/local/bin/codduo-menu" ]; then
    echo "Erro: Menu CODDUO-OS não encontrado!"
    echo "Verifique se o sistema foi instalado corretamente."
    exit 1
fi

# Executar menu
clear
echo "Iniciando CODDUO-OS..."
sleep 1
/usr/local/bin/codduo-menu