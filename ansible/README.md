# Ansible

Converges an Omarchy machine to this configuration. Omarchy owns the desktop;
this playbook owns the toolchain.

```bash
# bootstrap is in the repo README: chezmoi init --apply, then
sudo pacman -S ansible
make ansible    # from the repo root
```

Run it from a terminal in your Hyprland session -- the `omarchy` roles end in
desktop notifications that need the session bus. Dots are applied first so
`omarchy install ...` finds the configs already there and leaves them alone.

## Roles

Grouped by subject, referenced by path (`roles_path = ./roles`).

| Role | Owns |
| --- | --- |
| `configure/nopasswd-sudo` | permanent passwordless sudo (off by default) |
| `configure/makepkg` | MAKEFLAGS, so AUR builds use every core |
| `configure/evoluent-verticalmouse` | hwdb wheel-click fix |
| `configure/nautilus` | GTK file chooser sorts directories before files |
| `yubikey/tools` | ykman, touch detector, smartcard daemon |
| `yubikey/gpg` | fetches the public key, builds the card stubs |
| `yubikey/fido2` | prompts you to enrol the key for sudo and polkit |
| `omarchy/terminal` | installs ghostty, points xdg-terminal-exec at it |
| `omarchy/browser` | installs Brave, sets it as the XDG handler |
| `omarchy/editor` | default editor |
| `omarchy/theme` | theme |
| `omarchy/capture` | screenshot and screen recording directories |
| `omarchy/ai-usagebar` | multi-provider usage widget, with SuperGrok enabled |
| `omarchy/vpn` | upstream VPN widget with NetworkManager OpenConnect support |
| `omarchy/plugins` | installs and enables the configured third-party plugins |
| `runtimes/mise` | whatever `.config/mise/config.toml` lists |
| `runtimes/php` | packages, php.ini extensions, composer globals |
| `runtimes/rust` | rustup via Omarchy's installer |
| `software/packages` | packages that need no configuring |
| `software/protonmail-bridge` | Qt GUI, cert trust, aerc seed; login is a pause; headless unit stays off |
| `software/davmail` | package, user unit, enablement |
| `software/tableplus` | current vendor deb; AUR pins a yanked build |
| `software/tuitube` | vendor installer |
| `software/xiphos` | package, sword modules, one-shot settings seed |

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
| --- | --- | --- |
| terminal | `~/.config/xdg-terminals.list` | `omarchy/terminal` installs; the list is derived |
| agent | a one-word file, then `exec omarchy-agent` | `.config/omarchy/defaults/agent` |
| editor | `~/.local/state/omarchy/defaults/editor` | `omarchy/editor` -- chezmoi only applies `~/.config` |
| browser | all of `mimeapps.list`, via `xdg-settings` | `omarchy/browser` |
| theme | templates, backgrounds, per-app setters | `omarchy/theme` |

chezmoi copies files rather than linking them, so `sed -i` mutates the home
copy and leaves source intact. `make check` (`chezmoi status`) reports that
drift. Still skip `omarchy font set`: the font belongs in the ghostty config.

## Conventions

- Config lives in `home/` and is applied by chezmoi; the play only points at
  it. Systemd units are the exception, since `copy` can `register` a change
  and trigger `daemon-reload`. Xiphos `settings.xml` is the other: the app
  rewrites it on every launch, so the role seeds it once and leaves it alone.
- Steps needing a human use `ansible.builtin.pause` with the exact command in
  the prompt, guarded by a check so re-runs stay quiet.
- Every root task uses `become: true`. `make ansible` runs
  `omarchy-sudo-passwordless 15` first, which covers both `become` and `yay`
  (it shells out to sudo itself, outside become) and expires on its own.
- Source checkouts you develop in are not managed at all -- the `git` module
  resets working copies and has no idea jj exists.
