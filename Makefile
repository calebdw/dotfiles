SHELL:=/bin/bash

.PHONY: all setup dots check clean ansible

all: dots

# Fresh machine: install Omarchy, clone this repo, run `make setup`.
# Dots are applied before the playbook runs, so `omarchy install ...` finds the
# configs already in place and leaves them alone.
setup: all ansible

# Source lives in this repo (`~/sources/dotfiles`), not ~/.local/share/chezmoi.
# ~/.config/chezmoi/chezmoi.toml is created on first `chezmoi init` from
# home/.chezmoi.toml.tmpl and is what later `chezmoi apply` reads.
dots:
	chezmoi apply -S $(PWD)

# Omarchy migrations, `omarchy font set` and `omarchy display text size`
# rewrite config files with a plain `sed -i`. chezmoi copies rather than
# linking, so those writes land on the home copy; this reports the drift so
# the change can be ported back with `chezmoi re-add` rather than clobbered
# by the next apply.
check:
	chezmoi status -S $(PWD)

clean:
	find ~ -maxdepth 5 -type l -lname "$(PWD)/*" -delete

# Omarchy's own toggle: writes a NOPASSWD drop-in and arms a systemd timer to
# delete it 15 minutes later. Two things need it. ansible's own `become`,
# which is why there is no -K below; and yay, which refuses to run as root and
# shells out to sudo itself, outside become, so it would otherwise prompt in
# the middle of a run.
#
# This cannot be an ansible task: it ends in `gum confirm`, which exits 1
# without a TTY. Run from here it has one. Answer yes when it asks, and touch
# your key once for the sudo it needs to write the drop-in.
ansible:
	omarchy-sudo-passwordless 15
	cd ansible && \
	ansible-galaxy install -r requirements.yml && \
	ansible-playbook playbooks/local.yml
