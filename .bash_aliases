#!/bin/bash
alias converteps='find . -name "*.eps" -exec epstopdf {} \;'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias grep='grep --color=always'
alias his='history | grep'
alias less='less -R'
alias la='ls -A'
alias ls='ls --color=always'
alias ll='ls -AFhl --group-directories-first'
alias l='ls -CF'
alias nv='nvim'
alias python='python3'
alias pip='pip3'
alias g='git '
alias b='b4 '
alias lg='lazygit'

# Use bat instead of cat if available
# command -v bat &> /dev/null && alias cat='bat --paging=never'

alias dockup='docker compose up --build -d'
alias dockdown='docker compose down'
alias dock-stop-all='docker stop $(docker ps -q)'
alias dock-rm-all='docker rm -f $(docker ps -q)'
alias dock-sys-prune='docker system prune -f'

# Pass aliases through sudo
alias sudo='sudo '

# Laravel Sail
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias s='sail '

# Laravel Artisan
alias a='php artisan'
alias sa=' sail artisan '

export XDG_CONFIG_HOME=$HOME/.config
export COMPOSER_HOME=$HOME/.config/composer
export EDITOR=nvim

export PATH="./vendor/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$COMPOSER_HOME/vendor/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin"

export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

# Bash Completion for all aliases
if declare -F _complete_alias > /dev/null; then
    complete -F _complete_alias "${!BASH_ALIASES[@]}"
fi
