install-collections:
    ansible-galaxy collection install -r requirements.yml --force

setup: install-collections
    ANSIBLE_LOG_PATH=logs/ansible-setup-$(date +%Y%m%d-%H%M%S).log ansible-playbook -i inventory.ini playbook.yml --tags setup

revert_dotfiles:
    ANSIBLE_LOG_PATH=logs/ansible-revert-$(date +%Y%m%d-%H%M%S).log ansible-playbook -i inventory.ini playbook.yml --tags revert_dotfiles

dryrun: install-collections
    ANSIBLE_LOG_PATH=logs/ansible-dryrun-$(date +%Y%m%d-%H%M%S).log ansible-playbook -i inventory.ini playbook.yml --check --tags setup

preflight: install-collections
    ANSIBLE_LOG_PATH=logs/ansible-preflight-$(date +%Y%m%d-%H%M%S).log ansible-playbook -i inventory.ini playbook.yml --tags preflight

update: revert_dotfiles setup
