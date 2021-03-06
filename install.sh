#!/bin/bash

##TODO: use a map to for file -> link for single ln with params
##TODO: install ZSH
##TODO: install Oh-my-zsh
##TODO: install nvim
##TODO: install lambda-mod zsh theme
##TODO: after all of the above, then copy files so ZSH theme applies
##TODO: nvim plugin install
##TODO: install powerline font (cascadia cove powerline patch from nerdfonts currently)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIRNAME="$(dirname "$BASH_SOURCE")"

## Install prereqs
#sudo apt-get update
#sudo apt-get install zsh neovim tmux tree httpie

## Link NeoVim config first
mkdir -p ~/.config/nvim
ln -svf "$DIR/.config/nvim/init.vim" ~/.config/nvim/init.vim

## List of files to symlink in home dir
declare -a files=(".bashrc"
                  ".profile"
                  ".bash_profile"
                  ".tmux.conf"
                  ".zshrc"
                  )

## Symlink files to destination
## Prompt for each if removal is needed
for i in "${files[@]}"
do
  ln -siv "$(pwd)/$i" $HOME
done

## Copy theme
cp -v "$DIR/lambda-mod.zsh-theme" ~/.oh-my-zsh/themes/lambda-mod.zsh-theme

## Enable Git Credential Manager
echo "Enable Git Credential Manager on WSL?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"; break;;
        No ) exit;;
    esac
done

