#!/bin/bash
# -*- coding: utf-8 -*-

if [ ! -f ~/.git-prompt.sh ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
fi

wget https://raw.githubusercontent.com/Commandcracker/bashrc/main/src/.bashrc -O ~/.bashrc
wget https://raw.githubusercontent.com/Commandcracker/bashrc/main/src/.bash_profile -O ~/.bash_profile
wget https://raw.githubusercontent.com/Commandcracker/bashrc/main/src/.bash_aliases -O ~/.bash_aliases
wget https://raw.githubusercontent.com/Commandcracker/bashrc/main/src/.bash_login -O ~/.bash_login
wget https://raw.githubusercontent.com/Commandcracker/bashrc/main/src/.bash_path -O ~/.bash_path
