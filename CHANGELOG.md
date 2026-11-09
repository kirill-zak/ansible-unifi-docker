# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.0.0] - 2026-11-09

### Added

- Test matrix for AlmaLinux 8.x/9.x, Rocky Linux 8.x/9.x, Alpine 3.22/3.23,
  Debian 12/13, Fedora 43/44, Ubuntu 22.04/24.04/26.04.
- `Makefile` with `make create-venv`, `make update-venv`, `make activate` and
  `make test-molecule` targets (venv lives in the gitignored `.ansible/`).

### Changed

- Replaced the duplicated molecule test matrix in `ci.yml` and `release.yml`
  with a single source of truth in `.github/workflows/config.yml`.
- CI checks now use a stable `test-gate` job name, so branch protection rules
  no longer need updating when test versions change.
- Migrated molecule tests from the Docker driver to the Podman driver
  (`molecule-plugins[podman]`), running the container images with podman on
  GitHub runners.
- Pinned test tool versions in `requirements.txt` and pinned
  `community.general` in `requirements.yml` to a version range compatible
  with the pinned ansible-core (`>=11.0.0,<12.0.0`).
- Trimmed the molecule test sequence in `molecule/default/molecule.yml` to the
  used phases (drop dependency/prepare/cleanup/side_effect), silencing
  "missing playbook"/"missing requirements file" noise.
- `ansible-lint` now runs with `profile: production` and no skipped rules.
- Molecule converge installs only the `requests` Python package
  (`python3-requests`/`py3-requests`) instead of the Docker SDK for Python
  (`geerlingguy.pip`/`py3-docker-py`): `community.docker` 3.x talks to the
  Docker API over plain HTTP with `requests` and needs no Docker SDK.
- Molecule converge configures dockerd with the `vfs` storage driver: the
  test containers run a Docker daemon inside a podman container whose root
  filesystem is already overlay-backed, so the default `overlay2` driver
  cannot mount there (`invalid argument`). `vfs` works in any nested
  container environment.
- CentOS 8, EOL Alpine 3.16–3.19, Debian 10/11, Fedora 35–39 and
  Ubuntu 18.04/20.04 were removed from the test matrix.

### Fixed

- Molecule converge runs as a root user without sudo: under the rootless
  podman available on GitHub runners, sudo in the systemd-based images fails
  with `PAM account management error` (PAM cannot retrieve authentication
  info in the user namespace).
- Fedora 43/44 converge failing with `Could not import the libdnf5 python
  module`: Fedora 41+ reports `ansible_pkg_mgr=dnf5`, which makes the dnf
  module dispatch to the dnf5 backend, but the test images only ship the
  dnf4 (`python3-dnf`) bindings. The requests install now pins
  `use_backend: dnf4` on Fedora.
- AlmaLinux 8 converge failing with `ModuleNotFoundError: No module named
  'requests'`: the images default python3 to 3.12 via alternatives while the
  plain `python3-requests` package only targets the system python (3.6), so
  converge now installs the matching `python3.12-requests` variant.