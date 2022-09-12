# docker-irssi

[![Docker Version](https://img.shields.io/docker/v/hymnis/docker-irssi?sort=semver)](https://hub.docker.com/r/hymnis/docker-irssi/)
[![Docker Size](https://img.shields.io/docker/image-size/hymnis/docker-irssi?sort=semver)](https://hub.docker.com/r/hymnis/docker-irssi/)
[![Docker Pulls](https://img.shields.io/docker/pulls/hymnis/docker-irssi.svg)](https://hub.docker.com/r/hymnis/docker-irssi/)
[![Docker Stars](https://img.shields.io/docker/stars/hymnis/docker-irssi.svg)](https://hub.docker.com/r/hymnis/docker-irssi/)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Running `irssi` in a `screen` session with ssh and mosh access.

## Usage

Start the docker container with your public key(s):

```sh
docker run -d -p 2222:22 -p 2233:60000/udp -e AUTHORIZED_KEYS="ssh-rsa AAAA...== user@host" -e TZ="Europe/Stockholm" -v <irssi conf dir>:/home/user/.irssi:rw hymnis/docker-irssi
```

### Required

* `AUTHORIZED_KEYS`: Keys that are allowed to be used for login. Multiple keys are allowed and separeted by `,`.

### Recommended

* `-v <irssi conf dir>:/home/user/.irssi:rw`: Persistant storage of irssi configuration and logs.

### Optional

* `TZ`: Timezone override which allowes for specific timezone to be used.

## Connecting

Use ssh or mosh to connect to the host on specified port.

```sh
ssh -p 2222 user@<host>
```
or
```sh
mosh -p 2233 --ssh="ssh -p 2222" user@<host>
```

## License
[MIT](https://opensource.org/licenses/MIT)
