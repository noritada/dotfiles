#!/bin/bash

set -eux

dest="bundle/Vundle.vim"
if [ ! -e "${dest}" ]; then
    mkdir -p "$(dirname "${dest}")"
    git clone https://github.com/VundleVim/Vundle.vim.git "${dest}"
fi
