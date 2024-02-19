SHELL:=/bin/bash

.PHONY: all dots scripts clean ansible

all: dots scripts

dots:
	ln -sf $(PWD)/.alacritty.yml ~/
	ln -sf $(PWD)/.bash_aliases ~/
	ln -sf $(PWD)/.bashrc ~/
	ln -sf $(PWD)/.editorconfig ~/
	ln -sf $(PWD)/.latexmkrc ~/
	ln -sf $(PWD)/.tmux.conf ~/
	ln -sf $(PWD)/.vimrc ~/
	ln -sf $(PWD)/gitconfig ~/.gitconfig
	ln -sf $(PWD)/gitignore ~/.gitignore
	cp -asfv $(PWD)/.gnupg ~/
	cp -asfv $(PWD)/.config ~/ && find ~/.config -xtype l -delete
	find ~ -maxdepth 2 -xtype l -delete

scripts:
	cp -asfv $(PWD)/scripts/* ~/bin/
	find ~/bin -xtype l -delete

clean:
	rm ~/.alacritty.yml \
		~/.bash_aliases \
		~/.bashrc \
		~/.editorconfig \
		~/.latexmkrc \
		~/.tmux.conf \
		~/.vimrc \
		~/.gitconfig \
		~/.gitignore \
	find ~/bin -type l -lname "$(PWD)/scripts/*" -delete
	find ~/.config -type l -lname "$(PWD)/.config/*" -delete
	find ~/.gnupg -type l -lname "$(PWD)/.gnupg/*" -delete

ansible:
	cd ansible && \
	ansible-galaxy install -r requirements.yml && \
	ansible-playbook playbooks/local.yml -K
