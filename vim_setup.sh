#!/bin/bash

# copy from dotfiles
cp .vimrc ~
cp -vafR .vim ~

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install bundles
cd ~/.vim/bundle

git clone https://github.com/martinda/Jenkinsfile-vim-syntax.git
git clone https://github.com/w0rp/ale.git
git clone https://github.com/ryanoasis/vim-devicons.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git
git clone https://github.com/edkolev/promptline.vim
git clone https://github.com/PProvost/vim-ps1.git
git clone https://github.com/rodjek/vim-puppet.git
git clone https://github.com/mhinz/vim-signify.git
git clone https://github.com/leafgarland/typescript-vim.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/vim-airline/vim-airline-themes.git
git clone https://github.com/hashivim/vim-consul.git
git clone https://github.com/hashivim/vim-hashicorp-tools.git
git clone https://github.com/hashivim/vim-nomadproject.git
git clone https://github.com/hashivim/vim-ottoproject.git
git clone https://github.com/hashivim/vim-packer.git
git clone https://github.com/hashivim/vim-terraform.git
git clone https://github.com/hashivim/vim-vagrant.git
git clone https://github.com/hashivim/vim-vaultproject.git
git clone https://github.com/sheerun/vim-polyglot.git

cd -
