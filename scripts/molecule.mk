# Molecule test scenario
MOLECULE_SCENARIO ?= default

# Molecule binary from the venv (see infra.mk for VENV_DIR)
MOLECULE ?= $(VENV_DIR)/bin/molecule

# Prebuilt distro image the role is tested against
# (see molecule/default/molecule.yml); the defaults match the scenario defaults.
MOLECULE_DISTR ?= kirillzak/docker-alpine-ansible
MOLECULE_TAG ?= latest

# Run the full molecule test (create, converge, verify, destroy) for a scenario.
# The venv bin dir must be on PATH so molecule finds ansible-config/ansible;
# ANSIBLE_COLLECTIONS_PATH/ANSIBLE_ROLES_PATH point at the collections/roles
# installed by create-venv. CURDIR is used so the paths stay absolute when
# molecule spawns subprocesses.
test-molecule:
	export PATH="$(CURDIR)/$(VENV_DIR)/bin:$$PATH"; \
	export ANSIBLE_COLLECTIONS_PATH="$(CURDIR)/$(ANSIBLE_COLLECTIONS_DIR)"; \
	export ANSIBLE_ROLES_PATH="$(CURDIR)/$(ANSIBLE_ROLES_DIR)"; \
	export MOLECULE_DISTR="$(MOLECULE_DISTR)"; \
	export MOLECULE_TAG="$(MOLECULE_TAG)"; \
	$(MOLECULE) test --scenario-name $(MOLECULE_SCENARIO)

.PHONY: test-molecule