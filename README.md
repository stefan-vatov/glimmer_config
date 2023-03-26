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
just setup
just revert_dotfiles
just update
```

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
