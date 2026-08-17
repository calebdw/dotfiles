SHELL:=/bin/bash

.PHONY: all setup dots scripts check clean ansible clean-links

all: dots scripts clean-links

# Fresh machine: install Omarchy, clone this repo, run `make setup`.
# Dots are linked before the playbook runs, so `omarchy install ...` finds the
# configs already in place and leaves them alone.
setup: all ansible

dots:
	ln -sf $(PWD)/.editorconfig ~/
	ln -sf $(PWD)/.latexmkrc ~/
	ln -sf $(PWD)/.pg_format ~/
	ln -sf $(PWD)/.yamlfmt.yml ~/
	ln -sf $(PWD)/.config/opencode/AGENTS.md ~/.claude/CLAUDE.md
	cp -asfv $(PWD)/.gnupg ~/
	cp -asfv $(PWD)/.config ~/

# ~/.local/bin, not ~/bin: nothing on this system puts ~/bin on PATH, so
# scripts installed there (including the git-/jj- subcommands, which git and
# jj can only find via PATH) were unreachable.
scripts:
	mkdir -p ~/.local/bin
	cp -asfv $(PWD)/scripts/* ~/.local/bin/

# Omarchy migrations, `omarchy font set` and `omarchy display text size`
# rewrite config files with a plain `sed -i` (no --follow-symlinks), which
# replaces the symlink with a regular file and quietly detaches it from this
# repo. This reports any that have come loose so the change can be ported back
# in deliberately rather than clobbered by the next `make dots`.
check:
	@cd $(PWD)/.config && find . -type f -printf '%P\n' | while read -r f; do \
		t="$$HOME/.config/$$f"; \
		if [ -e "$$t" ] && [ ! -L "$$t" ]; then echo "detached: $$t"; fi; \
	done

# Only broken links that this repo made. Without the -lname filter this
# deletes every dangling symlink in $HOME five levels deep, including ones
# that have nothing to do with these dotfiles.
clean-links:
	find ~ -maxdepth 5 -xtype l -lname "$(PWD)/*" -delete

clean:
	find ~ -type l -lname "$(PWD)/*" -delete

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
