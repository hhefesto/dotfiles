#!/bin/sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/src/dotfiles                    # dotfiles directory
olddir=~/src/dotfiles/dotfiles_old             # old dotfiles backup directory
files="~/.zshrc ~/.emacs.d/init.el ~/.xmobarrc ~/.xmonad/xmonad.hs ~/.xsession ~/.Xresources"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
#mkdir -p ~/dev
mkdir -p ~/.emacs.d
mkdir -p ~/.xmonad
mkdir -p $dir
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

echo "Copying any existing dotfiles from ~ to $olddir"
mv ~/.zshrc $olddir
mv ~/.emacs.d/init.el $olddir
mv ~/.xmobarrc $olddir
mv ~/.xmonad/xmonad.hs $olddir
mv ~/.xsession $olddir
mv ~/.Xresources $olddir
echo "done (no error should have been displayed)"

echo "Creating symlink to $file in home directory."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/init.el ~/.emacs.d/init.el
ln -s $dir/xmobarrc ~/.xmobarrc
ln -s $dir/xmonad.hs ~/.xmonad/xmonad.hs
ln -s $dir/xsession ~/.xsession
ln -s $dir/Xresources ~/.Xresources
echo "done (no error should have been displayed)"
