unifi_docker
=========

Setup and run the UniFi SDN Controller in a Docker container

## Support distributive

* AlmaLinux `8.x` (`8.5` – `8.10`), `9.x` (`9.0` – `9.8`)
* Alpine Linux `3.22.x`, `3.23.x`
* Debian `12` (`Bookworm`), `13` (`Trixie`)
* Fedora `43`, `44`
* Rocky Linux `8.x` (`8.5` – `8.9`), `9.x` (`9.0` – `9.8`)
* Ubuntu `22.04` (`Jammy Jellyfish`), `24.04` (`Noble Numbat`), `26.04`

## Requirements

- Docker engine (installed by the dependency role `kirill_zak.docker`).
- Python 3 `requests` library on the target host (`python3-requests`, or
  `py3-requests` on Alpine): required by the `community.docker` modules
  used by the role.

## Role Variables

- `unifi_docker_tag`: Tag found at https://hub.docker.com/r/jacobalberty/unifi/tags
- `unifi_docker_tz`: Timezone. List can be found at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
- `unifi_docker_container_name`: Name of container. Default value `unifi`.
- `unifi_docker_network`: Name of docker network. Default value `unifi`.

## Dependencies

- Docker

## Example Playbook

```yaml
    - name: Install UniFi SDN controller
      hosts: unifi
      become: true
      vars:
        unifi_docker_container_name: unifi.local
      roles:
        - role: kirill_zak.docker
        - role: kirill_zak.unifi_docker
```

## License

GPL-2.0

## Author Information

https://kirill-zak.ru