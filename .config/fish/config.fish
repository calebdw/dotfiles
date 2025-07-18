# Settings
fish_vi_key_bindings

# Environment
set -x NODE_EXTRA_CA_CERTS /etc/ssl/certs/ca-certificates.crt
set -x EDITOR nvim

# Paths
fish_add_path --path ./vendor/bin
fish_add_path --path ./node_modules/bin
fish_add_path ~/go/bin
fish_add_path ~/.opencode/bin
fish_add_path -a ~/.config/composer/vendor/bin

# Aliases
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ll='ls -lhAF --group-directories-first'

# Abbreviations
abbr -a a php artisan
abbr -a s sail
abbr -a sa sail artisan
abbr -a nv nvim
abbr -a g git
abbr -a b b4
abbr -a lg lazygit
abbr -a j jj
abbr -a lj lazyjj

# abbr --command jj g git
# abbr --command jj ab absorb
# abbr --command jj sq squash

if status is-interactive
    # Integrations
    atuin init fish --disable-up-arrow | source
    starship init fish | source
end
