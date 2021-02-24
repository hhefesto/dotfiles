#!/bin/sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/src/dotfiles                    # dotfiles directory
olddir=~/src/dotfiles/dotfiles_old    # old dotfiles backup directory

files="~/Pictures/Screenshots/wallpaper.png ~/.doom.d/config.el ~/.doom.d/custom.el ~/.doom.d/init.el ~/.doom.d/packages ~/.zshrc ~/.xmobarrc ~/.xmonad/xmonad.hs ~/.xsession ~/.Xresources ~/.ghc/ghci.conf"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
# mkdir -p ~/dev
# mkdir -p ~/.emacs.d
mkdir -p ~/.xmonad
mkdir -p ~/.ghc/ghci.conf
mkdir -p ~/.doom.d
mkdir -p ~/Pictures/Screenshots
mkdir -p $dir
mkdir -p $olddir
echo "done"
echo ""

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"
echo ""

echo "Copying any existing dotfiles from ~ to $olddir"
mv ~/.gitconfig $olddir
mv ~/.zshrc $olddir
# mv ~/.emacs.d/init.el $olddir
mv ~/.xmobarrc $olddir
mv ~/.xmonad/xmonad.hs $olddir
mv ~/.xsession $olddir
mv ~/.Xresources $olddir
mv ~/.ghc/ghci.conf $olddir
mv ~/.doom.d/config.el $olddir
mv ~/.doom.d/custom.el $olddir
mv ~/.doom.d/init.el $olddir
mv ~/.doom.d/packages.el $olddir
echo "Finished doing backup for existing dotfiles (an error will appear for each non-existing dotfile)."
echo ""

echo "Creating symlink in home directory."
ln -s $dir/gitconfig ~/.gitconfig
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/xmobarrc ~/.xmobarrc
ln -s $dir/xmonad.hs ~/.xmonad/xmonad.hs
ln -s $dir/xsession ~/.xsession
ln -s $dir/Xresources ~/.Xresources
ln -s $dir/ghci.conf ~/.ghc/ghci.conf
ln -s $dir/config.el ~/.doom.d/config.el
ln -s $dir/custom.el ~/.doom.d/custom.el
ln -s $dir/init.el ~/.doom.d/init.el
ln -s $dir/packages.el ~/.doom.d/packages.el
ln -s $dir/wallpaper.png ~/Pictures/wallpaper.png

# doom-emacs install
echo "Installing Doom Emacs."
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

echo "done"
