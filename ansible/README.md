# Ansible

Converges an Omarchy machine to this configuration. Omarchy owns the desktop;
this playbook owns the toolchain.

```bash
sudo pacman -S ansible
make setup      # from the repo root: links dotfiles, then runs the playbook
make ansible    # just the playbook
```

Run it from a terminal in your Hyprland session -- the `omarchy` roles end in
desktop notifications that need the session bus. Dots are linked first so
`omarchy install ...` finds the configs already there and leaves them alone.

## Roles

Grouped by subject, referenced by path (`roles_path = ./roles`).

| Role | Owns |
|---|---|
| `configure/nopasswd-sudo` | permanent passwordless sudo (off by default) |
| `configure/makepkg` | MAKEFLAGS, so AUR builds use every core |
| `configure/evoluent-verticalmouse` | hwdb wheel-click fix |
| `yubikey/tools` | ykman, touch detector, smartcard daemon |
| `yubikey/gpg` | imports the public key, builds the card stubs |
| `yubikey/fido2` | prompts you to enrol the key for sudo and polkit |
| `omarchy/terminal` | installs ghostty, points xdg-terminal-exec at it |
| `omarchy/browser` | installs Brave, sets it as the XDG handler |
| `omarchy/editor` | default editor |
| `omarchy/theme` | theme |
| `omarchy/capture` | screenshot and screen recording directories |
| `toolchains/mise` | whatever `.config/mise/config.toml` lists |
| `toolchains/php` | packages, php.ini extensions, composer globals |
| `toolchains/rust` | rustup via Omarchy's installer |
| `software/packages` | packages that need no configuring |
| `software/davmail` | package, user unit, enablement |
| `software/tuitube` | vendor installer |

One role, one thing, each commentable out of the play on its own. Whatever
installs something also configures and enables it -- there is no role that
switches on units another role installed. So `software/packages` is only for
software with nothing to set up, and anything with a tail of its own gets a
role.

Prefer an Omarchy command, then a package, then a vendor installer. Read the
Omarchy script first: several `omarchy default ...` setters only write one
small file, and a file belongs in the repo rather than being reapplied every
run.

| Setting | Omarchy writes | Here |
|---|---|---|
| terminal | `~/.config/xdg-terminals.list` | `omarchy/terminal` installs; the list is derived |
| agent | a one-word file, then `exec omarchy-agent` | `.config/omarchy/defaults/agent` |
| editor | `~/.local/state/omarchy/defaults/editor` | `omarchy/editor` -- `make dots` only links `~/.config` |
| browser | all of `mimeapps.list`, via `xdg-settings` | `omarchy/browser` |
| theme | templates, backgrounds, per-app setters | `omarchy/theme` |

`cat >`, `printf >` and `>>` follow symlinks, so the file versions survive
being set from the menus. `sed -i` does not -- hence no `omarchy font set`,
and hence `make check`.

## Conventions

- Config lives in the repo and is linked by `make dots`; the play only points
  at it. Systemd units are the exception, since `copy` can `register` a change
  and trigger `daemon-reload`.
- Steps needing a human use `ansible.builtin.pause` with the exact command in
  the prompt, guarded by a check so re-runs stay quiet.
- Every root task uses `become: true`. `make ansible` runs
  `omarchy-sudo-passwordless 15` first, which covers both `become` and `yay`
  (it shells out to sudo itself, outside become) and expires on its own.
- Source checkouts you develop in are not managed at all -- the `git` module
  resets working copies and has no idea jj exists.
