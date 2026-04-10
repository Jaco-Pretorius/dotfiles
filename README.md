# dotfiles

# Install [HomeBrew](https://brew.sh/), then run the Brewfile
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install
```

# Copy user configs
```
cp gitconfig ~/.gitconfig
cp inputrc ~/.inputrc
```

# Configure MacVim
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
mvim -v +PluginInstall +qall

cd ~/.vim/bundle/ctrlp-cmatcher
./install.sh
```

# Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp zshrc ~/.zshrc
```
