#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Checking Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools are already installed."
else
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install

  until xcode-select -p &>/dev/null; do
    echo "Waiting for Xcode Command Line Tools to be installed"
    sleep 5
  done
fi

echo "Checking Homebrew..."
if command -v brew &>/dev/null; then
  echo "Homebrew is already installed."
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensures brew is available in the current shell session immediately
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update

echo "Installing Homebrew dependencies..."
brew bundle install

echo "Checking oh-my-zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh is already installed."
else
  echo "Installing oh-my-zsh..."

  # RUN_ZSH=no: Prevents the installer from spawning a new zsh shell immediately
  # --unattended: Prevents the installer from prompting for user input
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  cp zshrc ~/.zshrc
fi

echo "Setup complete!"
