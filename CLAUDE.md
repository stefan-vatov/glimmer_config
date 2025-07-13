# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Glimmer Config is a dotfiles management system built with Ansible. It automates the setup, management, and removal of personal configuration files (dotfiles) on macOS systems.

## Common Commands

### Setup and Management
- `just setup` - Run the complete setup playbook (installs packages, sets up dotfiles, configures applications)
- `just revert_dotfiles` - Remove all dotfile symlinks
- `just update` - Revert dotfiles and run setup again (useful for clean updates)
- `ansible-playbook -i inventory.ini playbook.yml --tags setup` - Direct Ansible command for setup
- `ansible-playbook -i inventory.ini playbook.yml --tags revert` - Direct Ansible command to revert dotfiles

### Development Commands
- `just` - List all available commands in the justfile
- `ansible-playbook -i inventory.ini playbook.yml --check` - Dry run to see what changes would be made
- `ansible-playbook -i inventory.ini playbook.yml --tags homebrew_packages` - Run only the homebrew packages role
- `ansible-playbook -i inventory.ini playbook.yml --tags dotfiles` - Run only the dotfiles role
- `ansible-playbook -i inventory.ini playbook.yml --tags config` - Run only the config role

## Architecture and Structure

### Ansible Roles Organization
The playbook uses three main roles, each handling a specific aspect of the configuration:

1. **homebrew_packages** (`roles/homebrew_packages/`)
   - Manages Homebrew taps, packages, and casks
   - Configuration in `defaults/main.yml` defines all packages to install
   - Task flow: Check Homebrew → Add taps → Install packages → Install casks

2. **dotfiles** (`roles/dotfiles/`)
   - Uses GNU Stow to manage dotfile symlinks
   - Supports both setup and revert operations
   - Handles legacy dotfile cleanup before creating new symlinks
   - Dotfiles are stored in the `dotfiles/` directory at the repository root

3. **config** (`roles/config/`)
   - Handles additional configuration not covered by dotfiles
   - Installs FiraCode Nerd Fonts
   - Configures VS Code Insiders with extensions and settings symlinks

### Key Implementation Details

- The playbook targets `localhost` and uses `local` connection for all tasks
- Ansible tags are used to control which parts of the configuration run
- Stow is used with the `--target=$HOME` flag to create symlinks in the user's home directory
- The system checks for existing non-symlink files before creating dotfile symlinks to avoid conflicts
- VS Code configuration uses a custom symlink approach rather than Stow due to the application's specific directory structure requirements

### Adding New Components

To add new dotfiles:
1. Place the file in `dotfiles/` directory with the same structure as it would appear in `$HOME`
2. Run `just update` to apply changes

To add new packages:
1. Edit `roles/homebrew_packages/defaults/main.yml`
2. Add to the appropriate list (taps, packages, or casks)
3. Run `just setup` or the homebrew_packages role specifically

To add new VS Code extensions:
1. Edit `roles/config/defaults/main.yml`
2. Add extension IDs to the `vscode_extensions` list
3. Run the config role
