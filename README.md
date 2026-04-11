# dotfiles

## Runbook for a clean laptop
1. Configure [github SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
1. Run ./setup.sh

## Configure iterm2
```
mkdir ~/Documents/iterm2-settings
cp iterm2/com.googlecode.iterm2.plist ~/Documents/iterm2-settings/

# In term:
# Preferences -> General -> Settings -> ✅ Load settings from a custom folder or URL
# Preferences -> General -> Settings -> Browse to ~/Documents/iterm2-settings
```

# Copy user configs
```
cp gitconfig ~/.gitconfig
cp inputrc ~/.inputrc
```
