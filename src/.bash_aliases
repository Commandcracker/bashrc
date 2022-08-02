#!/bin/bash
# -*- coding: utf-8 -*-

# vim & vi = nvim or vi = vim
if __check_exec nvim; then
    alias vim="nvim"
    alias vi="nvim"
else
    if __check_exec vim; then
        alias vi="vim"
    fi
fi

# Colorize output (good for log files)
alias diff='diff --color=auto'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# make human readable
alias df="df -h"
alias free='free -h'
alias du='du -h'

# better top

# prettier than top
if __check_exec htop; then
    alias top="htop" # https://github.com/htop-dev/htop
fi

# prettier than htop
if __check_exec bashtop; then
    alias top="bashtop" # https://github.com/aristocratos/bashtop
fi

# python is faster than bash
if __check_exec bpytop; then
    alias top="bpytop" # https://github.com/aristocratos/bpytop
fi

# c++ is faster than python
if __check_exec btop; then
    alias top="btop" # https://github.com/aristocratos/btop
fi

# ls or exa
if __check_exec exa; then
    alias ls='exa --color=always --group-directories-first'
    alias la='ls -a'

    # tree is faster than exa -T
    if __check_exec tree; then
        alias lt='tree'
    else
        alias lt='exa -T'
    fi

else
    alias ls='ls -h --color=always --group-directories-first'
    alias la='ls -A'

    if __check_exec tree; then
        alias lt='tree'
    fi

fi

alias ll='ls -l'
alias l.='la | egrep "^\."'
alias lla="la -l"
# if you mess up typing ls
alias l="ls"
alias sl="ls"

# cls
alias cls='clear'

# get ip command
if __check_exec curl; then
    alias publicip="curl https://ipinfo.io/ip ; echo"
else
    if __check_exec wget; then
        alias publicip="wget -qO- https://ipecho.net/plain ; echo"
    fi
fi

# cd into the previous working directory by omitting `cd`.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Bash Function To Extract File Archives Of Various Types
# usage: extract <file>
extract() {
    if [ -f "$1" ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.deb) ar x $1 ;;
        *.tar.xz) tar xf $1 ;;
        *.tar.zst) unzstd $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

alias ex="extract"
