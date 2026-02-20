set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf.vim'
Plugin 'jistr/vim-nerdtree-tabs'
call vundle#end()

filetype plugin indent on

colorscheme jellybeans
