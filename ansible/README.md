# Ansible

Ansible playbook to stand-up a new machine;


### Ansible Installation
Ansible first needs to be installed through `pip`

```bash
sudo apt update
sudo apt install python3-pip
sudo pip3 install ansible   # install globally
pip3 install --user ansible # install locally
```

Ansible binaries are installed in `~/.local/bin` which might need to be added to your PATH:
```bash
echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc
```

### Ansible Upgrade
```bash
sudo pip3 install --upgrade ansible   # upgrade globally
pip3 install --upgrade --user ansible # upgrade globally
```

### Ansible Galaxy packages

Community packages from Ansible Galaxy can be installed with:
```bash
ansible-galaxy install -r requirements.yml
```
