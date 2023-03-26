setup:
    ansible-playbook -i inventory.ini playbook.yml --tags setup

revert_dotfiles:
    ansible-playbook -i inventory.ini playbook.yml --tags revert_dotfiles

update: revert_dotfiles setup
