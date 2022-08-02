#!/bin/bash
# -*- coding: utf-8 -*-

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
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# on login
if [ -f ~/.bash_login ]; then
	. ~/.bash_login
fi

# Colors
BLUE="\033[0;34m"
RED="\033[0;31m"
BOLD="\033[1m"
NO_BOLD="\033[22m"
RESET="\033[0m"
BRIGHT_RED="\033[1;91m"
GRAY="\033[1;90m"
GREEN="\033[0;32m"

# Icons
fedora_icon=""

# Set PS1
if [ -f ~/.git-prompt.sh ]; then
	. ~/.git-prompt.sh
	export PROMPT_COMMAND='__git_ps1 "$BLUE$fedora_icon $RESET[$BLUE$BOLD\t $BRIGHT_RED$BOLD\u$RESET@$GRAY$BOLD\h $BLUE$BOLD\w$GREEN" "$RESET]\\$ "'
else
	export PS1="$BLUE$fedora_icon $RESET[$BLUE$BOLD\t $BRIGHT_RED$BOLD\u$RESET@$GRAY$BOLD\h $BLUE$BOLD\w$RESET]\\$ "
	unset PROMPT_COMMAND

	#function __setprompt {
	#	PS1="$PS1"
	#}

	#PROMPT_COMMAND='__setprompt'
fi

#unset PROMPT_COMMAND
#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ $(__git_ps1_colorize_gitstring)'
