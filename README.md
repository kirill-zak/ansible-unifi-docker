[![Build Status](https://travis-ci.com/calvinbui/ansible-unifi.svg?branch=master)](https://travis-ci.com/calvinbui/ansible-unifi)

# Ansible Unifi

UniFi SDN Controller for Debian/Ubuntu within a Docker container

##  Requirements

N/A

## Role Variables

`unifi_docker_tag`: Tag found at # https://hub.docker.com/r/jacobalberty/unifi/tags
`unifi_docker_tz`: Timezone. List can be found at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
`unifi_docker_folder`: Where all the data and configs will be stored

## Dependencies

- Docker

## Example Playbook

```yaml
- hosts: servers
  become: true
  roles:
    - role: calvinbui.ansible_docker
    - role: calvinbui.ansible_unifi_docker
```

## License

GPLv3

## Author Information

http://calvin.me
