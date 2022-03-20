#!/bin/sh
exec sshfs -p ${SSHFS_PORT} -f ${SSHFS_USER}@${SSHFS_HOST}:${SSHFS_HOST_PATH} /mnt/files -o IdentityFile=/root/.ssh/id_rsa -o auto_cache,reconnect,transform_symlinks,follow_symlinks,allow_other
