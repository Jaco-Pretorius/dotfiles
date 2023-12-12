# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
source "$HOME/.bootstrap/env.sh"
export PATH=$PATH:~/.local/bin

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}("
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%})%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="*"
# ZSH_THEME_GIT_PROMPT_CLEAN=""

# Copied from https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh#L72-L81
function wrap_git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo "(${ref#refs/heads/})"
}

PROMPT='$FG[070]%~%{$reset_color%}'
PROMPT+=' $FG[208]$(wrap_git_current_branch)%{$reset_color%}'
PROMPT+=' $ '

# Path to your oh-my-zsh installation.
export ZSH="/Users/jacopretorius/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

show-all-colors() {
  color=16;

  while [ $color -lt 245 ]; do
      echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
      ((color++));
  done
}

cd-script() {
  DATE_FOLDER="$(date +'%Y')/$(date +'%m')/$(date +'%d')"
  FOLDERNAME="/Users/${USER}/src/eng-manual-scripts/${DATE_FOLDER}"

  if [[ ! -d "$FOLDERNAME" ]]; then
      mkdir -p "$FOLDERNAME"
  fi

  cd "$FOLDERNAME"
}

on-call-script() {
  CURRENT_FOLDER=$(pwd)
  echo "Making a github on-call script out of $1"

  DATE_FOLDER="$(date +'%Y')/$(date +'%m')/$(date +'%d')"
  CHECKOUT_FOLDER="/Users/${USER}/src/eng-manual-scripts"

  cd $CHECKOUT_FOLDER
  mkdir -p "$DATE_FOLDER"
  cp "$CURRENT_FOLDER/$1" "$DATE_FOLDER/$1"

  git co main
  git reset --hard origin/main
  git checkout -b "jacopretorius/$1"
  git add .
  git commit -m "Adding script $1"
  git push origin HEAD

  cd $CURRENT_FOLDER
}

export EDITOR=vi
export HISTCONTROL=ignoredups
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export DISABLE_SPRING=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

alias editaliases="vim ~/.bash_profile && reload"
alias ll="ls -alh"
alias loopy=run_loop
alias reload=". ~/.bash_profile"
alias shutupvim="rm /var/tmp/*.swp"
alias fspec="FEATURES=1 RAILS_ENV=test rspec"
alias gst="git status"
alias gbr="git branch"
alias rebase="git fetch && git reset --hard origin/main"
alias be="bundle exec"
alias wip="git add . && git commit -m 'wip'"
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias migrate='bundle exec rake db:migrate'

# Stop sharing history between tabs
unsetopt inc_append_history
unsetopt share_history

eval "$(rbenv init -)"
