#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo -n "Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
  echo -n " - already installed ✅"
  echo ""
else
  echo -n " - installing"
  xcode-select --install

  until xcode-select -p &>/dev/null; do
    echo -n "."
    sleep 5
  done
  echo -n " ✅"
  echo ""
fi

echo -n "Homebrew"
if command -v brew &>/dev/null; then
  echo -n " - already installed ✅"
  echo ""
else
  echo -n " - installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensures brew is available in the current shell session immediately
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo -n " ✅"
  echo ""
fi
echo "Updating Homebrew"
brew update

echo "Installing Homebrew dependencies"
brew bundle install

echo -n "Oh-My-Zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo -n " - already installed ✅"
  echo ""
else
  echo -n " - installing"

  # RUN_ZSH=no: Prevents the installer from spawning a new zsh shell immediately
  # --unattended: Prevents the installer from prompting for user input
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  cp zshrc ~/.zshrc
  echo -n " ✅"
  echo ""
fi

echo -n "VundleVim"
if [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  echo -n " - already installed ✅"
  echo ""
else
  echo -n " - installing"
  echo ""
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp vimrc ~/.vimrc
fi
echo "Installing VundleVim plugins ✅"
vim +PluginInstall +qall

echo "Setup complete ✅"
