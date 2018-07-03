parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
export -f parse_git_branch

run_loop() {
  trap "exit" INT
  for i in {1..10}; do $1; done
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1
export PS1="\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;36m\]\W\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\$(parse_git_branch)\[\e[0m\]\[\e[00;37m\]\$ \[\e[0m\]"
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR=mvim
export HISTCONTROL=ignoredups
export HISTFILESIZE=5000

alias editaliases="vim ~/.bash_profile && reload"
alias ll="ls -alh"
alias loopy=run_loop
alias reload=". ~/.bash_profile"
alias shutupvim="rm /var/tmp/*.swp"
alias fspec="FEATURES=1 rspec"
alias gst="git status"
alias gbr="git branch"
alias rebase="git fetch && git reset --hard origin/master"
alias be="bundle exec"

if [ -f ~/.profile ]; then
  . ~/.profile
fi

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi
