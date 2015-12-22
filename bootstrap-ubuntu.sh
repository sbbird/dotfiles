#!/bin/bash

# zsh
sudo apt-get install zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc.old
mv ~/.zshenv ~/.zshenv.old
mv ~/.zlogin ~/.zlogin.old
ln -s .zshrc ~/.zsher
ln -s .zshenv ~/.zshenv
ln -s .zlogin ~/.zlogin

# emacs-24
sudo apt-add-repository ppa:cassou/emacs
sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg

## Prelude
curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh

rm -f ~/.emacs.d/personal/custom.el
ln -s emacs.d/custom.el ~/.emacs.d/personal/custom.el

rm -f ~/.emacs.d/prelude-modules.el
ln -s emacs.d/prelude-modules.el ~/.emacs.d/prelude-modules.el

mkdir -p ~/.config/autostart/
cp ubuntu/emacs.desktop ~/.config/autostart

# Guake
sudo apt-get install guake
