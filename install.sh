#!/bin/sh

# This dir
SCRIPT_DIR=~/dotfiles

# Target dir (where to create symbolic links)
TARGET_DIR=~/temp/dotfiles

# Create dir to store old configuration files
[ ! -d '$SCRIPT_DIR/old' ] && mkdir $SCRIPT_DIR/old

# Managed configuration files
FILES="
.vimrc
.zshrc
.conkyrc
vrc
.i3"

for f in $FILES
do
   # Create symlink for each managed file
   if [ -f "$f" ]; then
       echo "Save file '$TARGET_DIR/$f' to '$SCRIPT_DIR/old/$f'"
       mv $TARGET_DIR/$f $SCRIPT_DIR/old/$f 

       echo "Creating symlink '$TARGET_DIR/$f' -> '$SCRIPT_DIR/$f'"
       ln -s $SCRIPT_DIR/$f $TARGET_DIR/$f
   fi

   # do not touch symlinks
   [ -L "$f" ] && echo "File '$TARGET_DIR/$f' is symlink. Skipping..."
done


