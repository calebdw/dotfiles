# dotfiles

<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>

🏡 is where the 💚 is.

Configs live here and are symlinked into place. [Omarchy](https://omarchy.org)
owns the desktop; the Ansible playbook owns the toolchain.

## Fresh machine

Install Omarchy, then:

```bash
sudo pacman -S ansible
# https, not ssh: the key is on a YubiKey and is not set up yet. git config
# rewrites pushes to ssh once it is linked.
git clone https://github.com/calebdw/dotfiles.git ~/sources/dotfiles
cd ~/sources/dotfiles
make setup
```

Run it from a terminal in your Hyprland session. Two expected interruptions:
`omarchy-sudo-passwordless` wants a confirmation and one sudo, and if no FIDO2
key is enrolled the play stops and tells you to run
`omarchy setup security fido2` in another terminal.

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

Symlinks point at wherever the repo is; move it and re-run `make dots`.

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
| `make` | `dots`, `scripts`, `clean-links` |
| `make setup` | the above, then the playbook |
| `make dots` | symlinks `.config`, `.gnupg` and the top-level dotfiles into `$HOME` |
| `make scripts` | symlinks `scripts/` into `~/.local/bin` |
| `make ansible` | just the playbook |
| `make check` | reports configs that have come unlinked |
| `make clean-links` | removes this repo's broken symlinks |
| `make clean` | removes all of this repo's symlinks |

`make check` exists because some Omarchy commands rewrite configs with a plain
`sed -i`, which replaces the symlink with a regular file and quietly detaches
it -- the next `make dots` would then clobber the change. Port it back by hand
before re-linking.

See [ansible/README.md](ansible/README.md) for the roles.
