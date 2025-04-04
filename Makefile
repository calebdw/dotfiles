SHELL:=/bin/bash

.PHONY: all dots scripts clean ansible clean-links

all: dots scripts clean-links

dots:
	ln -sf $(PWD)/.alacritty.yml ~/
	ln -sf $(PWD)/.bash_aliases ~/
	ln -sf $(PWD)/.bash_completion ~/
	ln -sf $(PWD)/.bashrc ~/
	ln -sf $(PWD)/.editorconfig ~/
	ln -sf $(PWD)/.latexmkrc ~/
	ln -sf $(PWD)/.pg_format ~/
	ln -sf $(PWD)/.tmux.conf ~/
	ln -sf $(PWD)/.vimrc ~/
	ln -sf $(PWD)/.yamlfmt.yml ~/
	cp -asfv $(PWD)/.gnupg ~/
	cp -asfv $(PWD)/.config ~/

scripts:
	mkdir -p ~/bin
	cp -asfv $(PWD)/scripts/* ~/bin/

clean-links:
	find ~ -xtype l -delete

clean:
	find ~ -type l -lname "$(PWD)/*" -delete

ansible:
	cd ansible && \
	ansible-galaxy install -r requirements.yml && \
	ansible-playbook playbooks/local.yml -K
