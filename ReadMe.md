## Getting Started

Build your docker image:

`docker build . -t sshfs`

And run it:

### docker-compose

```yaml
version: '3.8'
services:
  sshfs:
    restart: unless-stopped
    container_name: my-sshfs
    devices:
      - /dev/fuse:/dev/fuse
    cap_add:
      - SYS_ADMIN
    build:
      context: .
      dockerfile: dockerfile
    image: topor:sshfs
    environment:
      - USER_ID
      - GROUP_ID
      - SSHFS_USER
      - SSHFS_HOST
      - SSHFS_PORT
      - SSHFS_HOST_PATH
      - TZ
    security_opt:
      - apparmor:unconfined
    volumes:
      - ${SSHFS_LOCAL_PATH}:/mnt/files:rshared
      - ${SSH_CONFIG_DIR}:/root/.ssh:ro
```
### Docker cli

```bash
    docker run --rm \
    --name my-sshfs \
    -e USER_ID \
    -e GROUP_ID \
    -e SSHFS_USER \
    -e SSHFS_HOST \
    -e SSHFS_PORT \
    -e SSHFS_HOST_PATH \
    -e TZ \
    -v <SSHFS_LOCAL_PATH>:/mnt/files:rshared \
    -v <SSH_CONFIG_DIR>:/root/.ssh:ro \
    --device=/dev/fuse:/dev/fuse \
    --security-opt apparmor=unconfined \
    --cap-add=SYS_ADMIN \
    --env-file=.env \
    sshfs
```

## Environment Variables

Some environment variables can be set to customize the behavior of the container
and its application.  The following list give more details about them.

| Variable       | Description                                  | Default |
|----------------|----------------------------------------------|---------|
|`APP_NAME`| Name of the application. | `sshfs` |
|`USER_ID`| ID of the user the application runs as.  See [User/Group IDs](#usergroup-ids) to better understand when this should be set. | `0` |
|`GROUP_ID`| ID of the group the application runs as.  See [User/Group IDs](#usergroup-ids) to better understand when this should be set. | `0` |
|`TZ`| [TimeZone] of the container.  Timezone can also be set by mapping `/etc/localtime` between the host and the container. | `London/Europe` |
|`SSHFS_USER`| The user that you want to use as the SSH user. | `root` |
|`SSHFS_HOST`| The IP address or hostname of the SSH server you are connecting to. | (unset) |
|`SSHFS_PORT`| The port of the SSH server. The default is 22. | `22` |
|`SSHFS_HOST_PATH`| The remote directory path of the host that you want to mount to | (unset) |
|`SSHFS_LOCAL_PATH`| The local directory that you want to mount the remote directory into. | (unset)|
|`SSH_CONFIG_DIR`| The local user directory where the .ssh config exists.| (unset)|

## Volumes & Parameters

Parameters are formatted as such: `internal`:`external`.

| Parameter | Function |
| :----: | --- |
| `-v ${SSHFS_LOCAL_PATH}:/mnt/files:rshared` | The volume mount to connect the local directory and container directory where the mount exists. |
| `-v ${SSH_CONFIG_DIR}:/root/.ssh:ro` | This mount connects the .ssh configuration on the host to the .ssh configuration in the container. ||
| `--devices /dev/fuse:/dev/fuse` | This allows the mount to run successfully. |
| `--security-opt  apparmor=unconfined` | The mount might not run without this command. Try it without first to see if the container runs. Related error: `fusermount3: mount failed: Operation not permitted` |
| `--cap-add SYS_ADMIN` | The mount might not run without this command. Try it without first to see if the container runs. Related error: `fusermount3: mount failed: Operation not permitted` |