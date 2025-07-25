#!/bin/bash

# CODDUO OS - Root Login Profile
# Display welcome message on first login

if [ -f /etc/motd ]; then
    clear
    cat /etc/motd
fi

# Set environment variables
export TERM=xterm-256color
export EDITOR=nano
export HISTSIZE=1000
export HISTFILESIZE=2000

# Basic aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Welcome message
echo -e "\n\033[33mBem-vindo ao CODDUO OS!\033[0m"
echo -e "\033[36mDigite 'sudo /root/install.sh' para instalar o sistema.\033[0m\n"