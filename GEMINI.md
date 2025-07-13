# Glimmer Config

This repository contains an Ansible playbook to set up a development environment on macOS.

## Key Features

- **Dotfile Management**: Uses Ansible and `stow` to manage dotfiles from a remote Git repository. It backs up existing dotfiles before creating symlinks.
- **Package Management**: Installs Homebrew and a curated list of packages and applications.
- **Application Configuration**: Configures Visual Studio Code with settings, keybindings, and extensions. It also installs custom fonts.
- **Reversibility**: Provides a mechanism to revert the changes made by the playbook.

## Project Structure

The repository is structured as a collection of Ansible roles, each responsible for a specific part of the setup process.

- **`homebrew_packages`**: This role is responsible for installing Homebrew and a list of packages and casks defined in `defaults/main.yml`.
- **`dotfiles`**: This role manages the user's dotfiles. It clones a dotfiles repository from `https://github.com/stefan-vatov/dotfiles.git`, backs up existing dotfiles, and uses `stow` to create symlinks. It also provides a way to revert the changes.
- **`config`**: This role handles application-specific configurations. It installs FiraCode Nerd Fonts and configures Visual Studio Code by symlinking settings and installing a list of extensions.

## How to Run

The `README.md` file provides instructions on how to run the playbook. The main commands are:

- `just setup`: Sets up the dotfiles and applications.
- `just revert_dotfiles`: Reverts the dotfiles to their previous state.
- `just update`: Updates the dotfiles repository and Homebrew packages.

The `justfile` in the root of the repository contains the definitions for these commands.
