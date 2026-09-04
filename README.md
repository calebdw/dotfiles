# dotfiles

<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>

🏡 is where the 💚 is.

Configs live in `home/` and are applied by [chezmoi](https://www.chezmoi.io)
into `$HOME` as regular files, not symlinks. [Omarchy](https://omarchy.org)
owns the desktop; the Ansible playbook owns the toolchain.

The chezmoi source directory is this repo (`~/sources/dotfiles`), not
`~/.local/share/chezmoi`. `.chezmoiroot` points chezmoi at `home/` so ansible,
the Makefile, and this README stay at the repo root.

## Fresh machine

Install Omarchy, then from a terminal in your Hyprland session:

```bash
# -b puts the binary in ~/.local/bin, not ./bin. --source keeps the clone in
# ~/sources/dotfiles, not ~/.local/share/chezmoi. https, not ssh: the key is
# on a YubiKey and is not set up yet. git config rewrites pushes to ssh once
# it is linked. It will prompt for the email that git/jj templates use.
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" \
  init --apply --source "$HOME/sources/dotfiles" calebdw

sudo pacman -S ansible
cd ~/sources/dotfiles
make ansible
```

`init` writes `~/.config/chezmoi/chezmoi.toml` from `home/.chezmoi.toml.tmpl`
(`sourceDir` / `workingTree`, so later `chezmoi apply` does not need `--source`).
`--apply` puts the configs in place before the playbook, so `omarchy install ...`
finds them and leaves them alone.

Two expected interruptions during `make ansible`: `omarchy-sudo-passwordless`
wants a confirmation and one sudo, and if no FIDO2 key is enrolled the play
stops and tells you to run `omarchy setup security fido2` in another terminal.

Then, by hand:

```bash
gh auth login
glab auth login
cp /path/to/id_ed25519_sk ~/.ssh/ && chmod 600 ~/.ssh/id_ed25519_sk
```

That last one cannot be automated or stored here. It is a non-resident FIDO2
credential -- the private key wrapped with a secret that never leaves the
YubiKey. The device keeps no copy, so `ssh-keygen -K` cannot recover it and
the copies you hold are the only ones that exist.

Edit files in `home/` (chezmoi names: `dot_config` is `~/.config`,
`private_dot_gnupg` is `~/.gnupg`), then `chezmoi apply`. `chezmoi edit --apply
~/.config/nvim/init.lua` does both.

## After the GPG key changes

Extending the subkeys happens in the offline-primary-key workflow, not here.
Afterwards:

```bash
gpg --armor --export 99981A649E1CA829A335E77493EDE5A0C788BC38 \
  > ansible/roles/yubikey/gpg/files/public-key.asc   # commit this
make ansible                                          # propagates the new dates

# GitHub and GitLab keep their own copy and neither accepts re-adding a key it
# already has, so delete then add.
gh gpg-key list && gh gpg-key delete <id>
gh gpg-key add ansible/roles/yubikey/gpg/files/public-key.asc
glab gpg-key list && glab gpg-key delete <id>
glab gpg-key add ansible/roles/yubikey/gpg/files/public-key.asc
```

Deliberately not automated: it deletes remote account state, and most runs the
key has not changed.

## Targets

| Target | Does |
|---|---|
| `make` | `chezmoi apply` |
| `make setup` | the above, then the playbook |
| `make dots` | `chezmoi apply` from this repo |
| `make ansible` | just the playbook |
| `make check` | `chezmoi status` — home files that drifted from source |
| `make clean` | removes leftover symlinks from the old linker |

`make check` exists because some Omarchy commands rewrite configs with a plain
`sed -i`. chezmoi copies files, so that no longer detaches a symlink; it
leaves the home copy different from source. Port the change back with
`chezmoi re-add <file>` before the next apply overwrites it.

See [ansible/README.md](ansible/README.md) for the roles.
