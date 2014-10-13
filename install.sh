#!/bin/bash

# Run this from the dotfiles dir
DOTFILES=`pwd`

# bash
mv ~/.bashrc ~/.bashrc.local 2> /dev/null
mv ~/.bash_aliases ~/.bash_aliases.old 2> /dev/null
ln -s $DOTFILES/bashrc ~/.bashrc
ln -s $DOTFILES/bash_aliases ~/.bash_aliases

# vim
mv ~/.vimrc ~/.vimrc.old 2> /dev/null
mv ~/.vim ~/.vim.old 2> /dev/null
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/vim ~/.vim

# dircolors
mv ~/.dircolors ~/.dircolors.old 2> /dev/null
ln -s $DOTFILES/dircolors.ansi-dark ~/.dircolors

# Git
mv ~/.gitconfig ~/.gitconfig.old 2> /dev/null
mv ~/git-completion.bash ~/git-completion.bash.old 2> /dev/null
ln -s $DOTFILES/gitconfig ~/.gitconfig
ln -s $DOTFILES/git-completion.bash ~/git-completion.bash
