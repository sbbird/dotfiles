#!/bin/bash

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
brew install zsh zsh-completions


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc.old
mv ~/.zshenv ~/.zshenv.old
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zlogin ~/.zlogin

# emacs-24
brew update
brew install emacs --with-cocoa
brew linkapps emacs


# Prelude
curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh

rm -f ~/.emacs.d/personal/custome.el
ln -s ~/dotfiles/custom.el ~/.emacs.d/personal/custom.el

chsh -s $(which zsh)
