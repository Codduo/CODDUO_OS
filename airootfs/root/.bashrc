#!/bin/bash

# CODDUO OS - Root Bash Configuration

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set prompt
PS1='\[\033[35m\][\u@\h \W]\$ \[\033[0m\]'

# History settings
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Check window size after each command
shopt -s checkwinsize

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Functions
function install_codduo() {
    echo -e "\033[33mIniciando instalação do CODDUO OS...\033[0m"
    sudo /root/install.sh
}