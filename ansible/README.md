# Ansible
Converges an Omarchy machine to this configuration. Omarchy owns the desktop;
this playbook owns the toolchain.
## Usage
```bash
sudo pacman -S ansible
make setup      # from the repo root: links dotfiles, then runs the playbook
```
## Steps that need you
Some things cannot be automated -- a physical touch on a security key being
the obvious one. Rather than doing them badly or leaving them undocumented,
the play stops and asks, using `ansible.builtin.pause`:
```yaml
- name: 'enrol the fido2 key by hand'
  ansible.builtin.pause:
    prompt: |
      Run this in another terminal, with the YubiKey plugged in:
          omarchy setup security fido2
      Press Enter to carry on, or Ctrl-C then A to abandon the run.
  when: not fido2_cred.stat.exists
```
Run the command in a second terminal, come back, press Enter, and the play
picks up where it left off. Each one is guarded by a check, so it only
interrupts on a machine that actually needs it -- nothing to skip past on a
re-run. Put any future manual step in this shape, with the exact command in
the prompt.
`make setup` links the dotfiles first on purpose: `omarchy install ...` only
copies its stock config into `~/.config/<app>` when that path is missing, so
linking first leaves this repo's configs alone.
Run it from a terminal inside your Hyprland session. The `omarchy` role calls
the same commands the Omarchy menus call, and each one ends with a desktop
notification that needs the session bus.
To run just the playbook:
```bash
make ansible
```
## Roles
Roles are grouped by what they are for, and referenced by path -- `roles_path`
is `./roles`, so a name like `configure/nopasswd-sudo` resolves on its own.
| Role | Owns |
|---|---|
| `configure/nopasswd-sudo` | permanent passwordless sudo drop-in (off by default) |
| `configure/evoluent-verticalmouse` | Evoluent VerticalMouse hwdb entry |
| `omarchy/fido2` | prompts you to enrol the key if it is not already |
| `omarchy/terminal` | installs ghostty, points xdg-terminal-exec at it |
| `omarchy/browser` | installs Brave, sets it as the XDG handler |
| `omarchy/editor` | default editor |
| `omarchy/theme` | theme |
| `omarchy/capture` | screenshot and screen recording directories |
| `toolchains/mise` | whatever `.config/mise/config.toml` lists |
| `toolchains/php` | php packages, php.ini extensions, composer globals |
| `toolchains/rust` | rustup toolchain and cargo tools |
| `software/packages` | repo and AUR packages that need no configuring |
| `software/yubikey` | ykman, touch detector, smartcard daemon |
| `software/davmail` | package, user unit, enablement |
| `software/tuitube` | vendor installer |
One role, one thing, each commentable out of `playbooks/local.yml` on its own.
A role that installs something also configures it and enables it -- there is
no role that goes around switching on units another role installed, and no
central package list that owns software someone else has to set up. That is
why php, python and rust carry their own pacman packages, and why
`software/packages` is only for software with nothing to set up.
A `toolchains/` role owns an ecosystem end to end: the runtime, its package
manager, and whatever that manager installs globally -- `composer global`,
`uv tool`, `cargo install` -- but only when the tool is genuinely part of that
ecosystem. Something like `b4` that merely happens to be written in Python
belongs with the software it is used alongside, not filed by implementation
language. `toolchains/mise` is the same idea one level up,
since mise is a toolchain manager rather than a toolchain; node comes from
there rather than from a role of its own.
Roles that need an AUR package do not reimplement the idempotence for it:
```yaml
- ansible.builtin.include_role:
    name: software/packages
    tasks_from: aur
  vars:
    aur_packages: ['davmail']
```
Every task that needs root uses `become: true`, so privileges are ansible's
problem and not a matter of sequencing, and ordering barely matters as a
result.
Sudo is handled outside the playbook entirely. `make ansible` runs
`omarchy-sudo-passwordless 15` first, which drops in a NOPASSWD rule and arms
a systemd timer to remove it a quarter of an hour later. That covers both
ansible's own `become` (hence no `-K`) and `yay`, which refuses to run as root
and shells out to `sudo` itself, outside become, so it would otherwise stop
mid-run waiting for a password.
It has to happen there rather than in a task: the script ends in `gum
confirm`, which exits 1 without a TTY, so an ansible task would silently get
"Aborted. No changes made." The `configure/nopasswd-sudo` role still exists
for a permanent rule, but it is off by default and this makes it unnecessary.
Config files are not written inline by a task. Anything that belongs in
`~/.config` lives in this repo and is linked by `make dots` -- the playbook
only enables or points at it. Systemd unit files are the exception: they are
installation plumbing rather than something you hand-edit, and a task that
copies them can `register` the change and trigger `daemon-reload`, which a
symlink cannot.
## Which Omarchy settings are tasks and which are files
Read the script before adding an `omarchy` command to a role. Several of the
`omarchy default ...` setters only write one small file, and a file is better
owned by the repo than reapplied by a play every time:
| Setting | What Omarchy does | Where it lives here |
|---|---|---|
| terminal | `omarchy install terminal` adds the package and heredocs into `~/.config/xdg-terminals.list` | `omarchy/terminal`; the list is derived, not carried in this repo |
| agent | writes a one-word file, then `exec omarchy-agent` -- unusable from a play | `.config/omarchy/defaults/agent` |
| editor | writes `~/.local/state/omarchy/defaults/editor` | `omarchy/editor`, because `make dots` only links `~/.config` |
| browser | `xdg-settings`, which rewrites all of `mimeapps.list` | `omarchy/browser` |
| theme | renders templates, swaps backgrounds, runs per-app setters | `omarchy/theme` |
Two things make the file versions safe. `cat >`, `printf >` and `>>` all
follow symlinks, so running the Omarchy command later writes *into* this repo
rather than replacing the link. `sed -i` does not, which is why `omarchy font
set` is avoided and why `make check` exists.
## Adding and removing software
Most things are a package name in
`roles/software/packages/defaults/main.yml`, and nothing else in the tree
references those lists. AUR packages go in `packages_aur` and are installed
with `yay`. Anything that needs configuring or enabling gets its own role
instead -- see `software/yubikey`.
## What this playbook does not manage
Source checkouts you develop in. `update`/`force` on the `git` module resets
remotes and the working copy, and it has no idea jj exists -- pointing it at a
colocated repo moves git's HEAD out from under jj's working copy. Anything you
hack on gets cloned once and then left alone.
