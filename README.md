# Glimmer Config

![Glimmer Logo](glimmer.png)

Glimmer Config is a collection of configuration files and scripts to set up and manage your dotfiles. This repository helps to automate the process of managing your dotfiles, making it easy to set up, update, and revert to previous configurations.

## How to Run

### Setting up your dotfiles

To set up your dotfiles, run the following command:

```bash
ansible-playbook -i inventory.ini playbook.yml --tags setup
```

### Removing dotfiles

To remove the dotfiles, run the following command:

```bash
ansible-playbook -i inventory.ini playbook.yml --tags revert_dotfiles
```

Alternatively, if you have just installed the repository, you can use the `just` commands:

```bash
just install-collections  # Install required Ansible Galaxy collections
just setup                # Full setup (automatically installs collections)
just revert_dotfiles
just update
```

## Dependencies

### Ansible Galaxy Collections

This project requires specific Ansible Galaxy collections to function properly. The required collections are defined in `requirements.yml`:

- `community.general` - Used for Homebrew package management

#### Installing Collections

Collections are automatically installed when you run `just setup`, `just dryrun`, or `just preflight`. You can also install them manually:

```bash
just install-collections
```

Or using ansible-galaxy directly:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Safety and Testing

### Pre-flight Checks

Before running the full setup, validate that your system meets all requirements:

```bash
just preflight
```

Or using ansible-playbook directly:

```bash
ansible-playbook -i inventory.ini playbook.yml --tags preflight
```

### Dry-run Mode

Test what changes would be made without actually applying them:

```bash
just dryrun
```

Or using ansible-playbook directly:

```bash
ansible-playbook -i inventory.ini playbook.yml --check --tags setup
```

### Logging

All playbook runs now generate timestamped log files in the `logs/` directory for troubleshooting and audit purposes. Log files are automatically created with names like:

- `logs/ansible-setup-20240101-120000.log`
- `logs/ansible-dryrun-20240101-120000.log`
- `logs/ansible-preflight-20240101-120000.log`

## Troubleshooting

If you encounter any issues, you can manually manage your dotfiles using the following commands:

### Stow top-level dotfiles

```bash
stow -t ~ -d ~/.dotfiles/sv -R . --ignore='.DS_Store'
```


### Remove top-level dotfiles

```bash
stow -t ~ -d ~/.dotfiles/sv -D . --ignore='.DS_Store'
```

### Manually remove `_sv` files

```bash
ls -lahS --color=never | grep _sv | awk '{print $9}' | xargs rm
```


## Post-Installation Tasks

After setting up your dotfiles, you may need to manually perform some additional steps:

- Source your `.gitconfig` file in the appropriate manner
