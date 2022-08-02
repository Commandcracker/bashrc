#!/bin/bash
# -*- coding: utf-8 -*-

if [ ! -f ~/.git-prompt.sh ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
fi
