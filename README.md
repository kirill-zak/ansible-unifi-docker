# Ansible Unifi

UniFi SDN Controller within a Docker container

## Support distributive

* Alma Linux `9.0`, `9.1`, `9.2`
* Alpine Linux 3.16.x (`3.16.0`, `3.16.1`, `3.16.2`, `3.16.3`, `3.16.4`, `3.16.5`, `3.16.6`, `3.16.7`, `3.16.8`, `3.16.9`)
* Alpine Linux `3.17.x` (`3.17.0`, `3.17.1`, `3.17.2`, `3.17.3`, `3.17.4`, `3.17.5`, `3.17.6`, `3.17.7`)
* Alpine Linux `3.18.x` (`3.18.0`, `3.18.2`, `3.18.3`, `3.18.4`, `3.18.5`, `3.18.6`)
* CentOS `8`
* Debian `10` (`Buster`)
* Debian `11` (`Bullseye`)
* Fedora `35`, `36`, `37`, `38`, `39`
* Rocky Linux `9.0`, `9.1`, `9.2`
* Ubuntu `18.04` (`Bionic Beaver`)
* Ubuntu `20.04` (`Focal Fossa`)
* Ubuntu `22.04` (`Jammy Jellyfish`)

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