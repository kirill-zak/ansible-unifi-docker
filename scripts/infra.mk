# Ansible venv location
VENV_DIR ?= .ansible

# Python interpreter used to create the venv
PYTHON ?= python3

# File with Python dependencies
REQUIREMENTS ?= requirements.txt

# Ansible Galaxy requirements (collections), installed into the venv
REQUIREMENTS_GALAXY ?= requirements.yml

# Ansible Galaxy requirements (roles), installed into the venv
ROLES_GALAXY ?= roles.yml

# Directory (inside the venv) where ansible-galaxy installs collections
ANSIBLE_COLLECTIONS_DIR ?= $(VENV_DIR)/collections

# Directory (inside the venv) where ansible-galaxy installs roles
ANSIBLE_ROLES_DIR ?= $(VENV_DIR)/roles

# Create the virtual environment and install dependencies.
# Mirrors the two install steps of the CI workflows (pip + ansible-galaxy).
# --force makes ansible-galaxy install into the venv dirs even when the same
# collections/roles already exist at the user level (~/.ansible).
create-venv:
	$(PYTHON) -m venv $(VENV_DIR)
	$(VENV_DIR)/bin/pip install --upgrade pip
	$(VENV_DIR)/bin/pip install -r $(REQUIREMENTS)
	ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)" \
		$(VENV_DIR)/bin/ansible-galaxy collection install --force -r $(REQUIREMENTS_GALAXY)
	ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)" \
		$(VENV_DIR)/bin/ansible-galaxy role install --force -p $(ANSIBLE_ROLES_DIR) -r $(ROLES_GALAXY)

# Update installed packages and collections to the latest versions within the venv
update-venv:
	$(VENV_DIR)/bin/pip install --upgrade pip
	$(VENV_DIR)/bin/pip install --upgrade -r $(REQUIREMENTS)
	ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)" \
		$(VENV_DIR)/bin/ansible-galaxy collection install --force --upgrade -r $(REQUIREMENTS_GALAXY)
	ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)" \
		$(VENV_DIR)/bin/ansible-galaxy role install --force --upgrade -p $(ANSIBLE_ROLES_DIR) -r $(ROLES_GALAXY)

# Open a new interactive shell with the venv declared on PATH.
# This mimics "source $(VENV_DIR)/bin/activate", but works from make:
# recipes run in a subshell, so the environment cannot be changed in the
# calling shell. Exit the spawned shell with 'exit' to return.
activate:
	@test -x "$(VENV_DIR)/bin/ansible" || { echo "'$(VENV_DIR)' venv not found, run 'make create-venv' first" >&2; exit 1; }
	@export PATH="$(CURDIR)/$(VENV_DIR)/bin:$$PATH"; \
	export ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)"; \
	export ANSIBLE_ROLES_PATH="$(CURDIR)/$(ANSIBLE_ROLES_DIR)"; \
	echo "Activated $(VENV_DIR) venv. Type 'exit' to leave."; \
	exec "$$SHELL"

.PHONY: create-venv update-venv activate