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
