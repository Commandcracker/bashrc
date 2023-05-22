#!/bin/bash
# -*- coding: utf-8 -*-

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# by red
export EDITOR=nvim

__check_exec() {
	command -v "$1" >/dev/null
	# optional: which "$1" &>/dev/null
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# on login
if [ -f ~/.bash_login ]; then
	. ~/.bash_login
fi

# escape sequences see https://en.wikipedia.org/wiki/ANSI_escape_code
ESC='\033'
CSI="$ESC["

# see https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
CS="\["
CW="\]"

# Colors
BLUE="$CS${CSI}0;34m$CW"
RED="$CS${CSI}0;31m$CW"
BOLD="$CS${CSI}1m$CW"
NO_BOLD="$CS${CSI}22m$CW"
RESET="$CS${CSI}0m$CW"
BRIGHT_RED="$CS${CSI}1;91m$CW"
GRAY="$CS${CSI}1;90m$CW"
GREEN="$CS${CSI}0;32m$CW"

# Icons see https://www.nerdfonts.com/cheat-sheet
fedora_icon=""

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

prompt_symbol=@

if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
    #prompt_color='\[\033[;94m\]'
    #info_color='\[\033[1;31m\]'
    # Skull emoji for root terminal
    prompt_symbol=💀
fi

# Set PS1
if [ -f ~/.git-prompt.sh ]; then
	. ~/.git-prompt.sh
	export PROMPT_COMMAND='__git_ps1 "$BLUE$fedora_icon $RESET[$BLUE$BOLD\t $BRIGHT_RED$BOLD\u$RESET$prompt_symbol$GRAY$BOLD\h $BLUE$BOLD\w$GREEN" "$RESET]\\$ "'
else
	export PS1="$BLUE$fedora_icon $RESET[$BLUE$BOLD\t $BRIGHT_RED$BOLD\u$RESET$prompt_symbol$GRAY$BOLD\h $BLUE$BOLD\w$RESET]\\$ "
	unset PROMPT_COMMAND

	#function __setprompt {
	#	PS1="$PS1"
	#}

	#PROMPT_COMMAND='__setprompt'
fi

#unset PROMPT_COMMAND
#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ $(__git_ps1_colorize_gitstring)'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
