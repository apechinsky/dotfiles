#!/bin/sh

#FILES=~/dotfiles/*
FILES="
.vimrc
.zshrc
.conkyrc
.i3"

TARGET=~/temp/dotfiles

for f in $FILES
do
   ln -s ~/dotfiles/$f $TARGET/$f
done


