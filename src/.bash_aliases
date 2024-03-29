#!/bin/bash
# -*- coding: utf-8 -*-

# dnf5 > dnf
if __check_exec dnf5; then
    # https://fedoraproject.org/wiki/Changes/ReplaceDnfWithDnf5
    alias dnf="dnf5"
fi

# codium > code
if __check_exec codium; then
    # https://github.com/VSCodium/vscodium
    alias code="codium"
    alias vscodium="codium"
fi

# vim & vi = nvim or vi = vim
if __check_exec nvim; then
    # https://neovim.io/
    alias vim="nvim"
    alias vi="nvim"
else
    if __check_exec vim; then
        alias vi="vim"
    fi
fi

if __check_exec lvim; then
    # https://www.lunarvim.org
    alias vi="lvim"
    alias vim="lvim"
    alias nvim="lvim"
fi

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'     # reset underline
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
    alias publicip="curl https://ifconfig.co"
    alias publicipv4="curl -4 https://ifconfig.co"
    alias publicipv6="curl -6 https://ifconfig.co"
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

# Tell me what you do
alias cp="cp -v"
alias rm="rm -v"
alias rmdir="rmdir -v"
alias mv="mv -v"
# https://superuser.com/questions/234199/good-block-size-for-disk-cloning-with-diskdump-dd#answer-234204
alias dd="dd bs=64K status=progress"

set_java_alias() {
    local version=$1
    local jdk_path="/usr/lib/jvm/temurin-${version}-jdk/bin/java"
    local jre_path="/usr/lib/jvm/temurin-${version}-jre/bin/java"
    local openjdk_path="/usr/lib/jvm/jre-${version}-openjdk/bin/java"
    local java_path

    if [[ -x "$jdk_path" ]]; then
        java_path="$jdk_path"
    elif [[ -x "$jre_path" ]]; then
        java_path="$jre_path"
    elif [[ -x "$openjdk_path" ]]; then
        java_path="$openjdk_path"
    else
        return 1
    fi

    alias "java${version}=${java_path}"
}

set_java_alias 8
set_java_alias 11
set_java_alias 17
set_java_alias 19
set_java_alias 20
