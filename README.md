# dotfiles

<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/calebdw/dotfiles-config-nvim"><img src="https://dotfyle.com/calebdw/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>

🏡 is where the 💚 is.

## Installation

To install simply execute `make`, to uninstall `make clean`.

### Ansible

#### Ansible Installation

Ansible first needs to be installed through `pip`

```bash
sudo apt update
sudo apt install python3-pip
sudo pip3 install ansible   # globally
pip3 install --user ansible # locally
# upgrade
sudo pip3 install --upgrade ansible   # globally
pip3 install --upgrade --user ansible # locally
```

> [!NOTE]
> Ansible binaries are installed in `~/.local/bin` which needs to be in your PATH.

To play the Ansible playbook, execute `make ansible`.
