#!/bin/bash
cp ./vim-config/.vimrc ~ # Copies vimrc file to home directory

if [ ! -f ~/.vim/bundle/Vundle.vim ]; then # Installs Vundle if it does not exist
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall # Installs vim setup
