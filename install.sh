#!/bin/bash

# Run this from the dotfiles dir
DOTFILES=`pwd`



# bash
if [ -h ~/.bashrc ]
then rm ~/.bashrc
else mv ~/.bashrc{,.old} 2> /dev/null
fi
ln -s $DOTFILES/bashrc ~/.bashrc

if [ -h ~/.bash_aliases ]
then rm ~/.bash_aliases
else mv ~/.bash_aliases{,.old} 2> /dev/null
fi
ln -s $DOTFILES/bash_aliases ~/.bash_aliases



# vim
if [ -h ~/.vimrc ]
then rm ~/.vimrc
else mv ~/.vimrc{,.old} 2> /dev/null
fi
ln -s $DOTFILES/vimrc ~/.vimrc

if [ -h ~/.vim ]
then rm ~/.vim
else mv ~/.vim{,.old} 2> /dev/null
fi
ln -s $DOTFILES/vim ~/.vim



# dircolors
if [ -h ~/.dircolors ]
then rm ~/.dircolors
else mv ~/.dircolors{,.old} 2> /dev/null
fi
ln -s $DOTFILES/dircolors.ansi-dark ~/.dircolors



# Git
if [ -h ~/.gitconfig ]
then rm ~/.gitconfig
else mv ~/.gitconfig{,.old} 2> /dev/null
fi
ln -s $DOTFILES/gitconfig ~/.gitconfig

if [ -h ~/.git-completion.bash ]
then rm ~/.git-completion.bash
else mv ~/.git-completion.bash{,.old} 2> /dev/null
fi
ln -s $DOTFILES/git-completion.bash ~/.git-completion.bash

if [ -h ~/.git-prompt.sh ]
then rm ~/.git-prompt.sh
else mv ~/.git-prompt.sh{,.old} 2> /dev/null
fi
ln -s $DOTFILES/git-prompt.sh ~/.git-prompt.sh



# PostgreSQL
if [ -h ~/.psqlrc ]
then rm ~/.psqlrc
else mv ~/.psqlrc{,.old} 2> /dev/null
fi
ln -s $DOTFILES/psqlrc ~/.psqlrc
