#!/usr/bin/env bash

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
echo "Setup complete!"
