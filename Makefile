SHELL:=/bin/bash

.PHONY: all nvim dots scripts clean

all: nvim dots scripts

nvim:
	cp -asfv $(PWD)/nvim ~/.config/
	find ~/.config -xtype l -delete

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
        ~/.gnupg/scdaemon.conf
	rm -rf ~/.config/nvim
	find ~/bin -type l -lname "$(PWD)/scripts/*" -delete
	find ~/.gnupg -type l -lname "$(PWD)/.gnupg/*" -delete
