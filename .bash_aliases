#!/bin/bash
alias converteps='find . -name "*.eps" -exec epstopdf {} \;'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias grep='grep --color=always'
alias his='history | grep'
alias less='less -R'
alias la='ls -A'
alias ls='ls --color=always'
alias ll='ls -alFh'
alias l='ls -CF'
alias nv='nvim'
alias python='python3'
alias pip='pip3'

alias dockup='docker compose up --build -d'
alias dockdown='docker compose down'
alias dock-stop-all='docker stop $(docker ps -q)'
alias dock-rm-all='docker rm -f $(docker ps -q)'
alias dock-sys-prune='docker system prune -f'

function g { grep -R "$1" --include=\*.php --exclude-dir={vendor,storage,uploads,database,migrations-archive}; }
function gl { grep -Rl "$1" --include=\*.php --exclude-dir={vendor,storage,uploads,database,migrations-archive}; }

# Pass aliases through sudo
alias sudo='sudo '

# Laravel Sail
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias s='sail'

# PHP Deployer
alias dep='vendor/bin/dep'

# Laravel Artisan
alias a='php artisan'
alias sa=' sail artisan '
alias pest='sail bin pest'

export PATH="~/bin:$PATH"
export PATH="$PATH:$COMPOSER_HOME/vendor/bin"
export PATH="$PATH:~/.cargo/bin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:./vendor/bin"
export COMPOSER_HOME=~/.config/composer

# Bash Completion for all aliases
complete -F _complete_alias "${!BASH_ALIASES[@]}"
