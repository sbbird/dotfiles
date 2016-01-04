#!/bin/bash

# curl
sudo apt-get install curl

# swap capslock and ctrl
sudo apt-get install gnome-tweak-tool

# zsh
sudo apt-get install zsh
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc.old
mv ~/.zshenv ~/.zshenv.old
mv ~/.zlogin ~/.zlogin.old
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zlogin ~/.zlogin

# emacs-24
sudo apt-add-repository ppa:cassou/emacs
sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg

## Prelude
curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh

rm -f ~/.emacs.d/personal/custom.el
ln -s ~/dotfiles/emacs.d/custom.el ~/.emacs.d/personal/custom.el

rm -f ~/.emacs.d/prelude-modules.el
ln -s ~/dotfiles/emacs.d/prelude-modules.el ~/.emacs.d/prelude-modules.el

mkdir -p ~/.config/autostart/
cp ~/dotfiles/ubuntu/emacs.desktop ~/.config/autostart

# Guake
sudo apt-get install guake
