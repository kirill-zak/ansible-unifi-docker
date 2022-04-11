# Ansible Unifi

UniFi SDN Controller within a Docker container

## Support distributive

* CentOS 7
* CentOS 8
* Debian 10 (Buster)
* Debian 11 (Bullseye)
* Fedora 35
* Ubuntu 18.04 (Bionic Beaver)
* Ubuntu 20.04 (Focal Fossa)

##  Requirements

Docker engine

## Role Variables

- `unifi_docker_tag`: Tag found at # https://hub.docker.com/r/jacobalberty/unifi/tags
- `unifi_docker_tz`: Timezone. List can be found at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
- `unifi_docker_container_name`: Name of container
- `unifi_docker_network`: Name of docker network

## Dependencies

- Docker

## Example Playbook

```yaml
- name: Install Ubiquiti UniFi controller
  hosts: unifi
  become: true
  vars:
    unifi_docker_container_name: unifi.local
  roles:
    - role: kirill_zak.docker
    - role: kirill_zak.unifi_docker
```

## License

GPLv2

## Author Information

https://kirill-zak.ru

Based on [Ansible role](https://github.com/calvinbui/ansible-unifi-docker) by [Calvin Bui](https://github.com/calvinbui).