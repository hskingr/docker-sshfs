FROM jlesage/baseimage:debian-11

# set environment variables
ENV APP_NAME="sshfs"
ENV USER_ID=""
ENV GROUP_ID=""
ENV TZ=""
ENV HOME="/root"
ENV SSHFS_USER=""
ENV SSHFS_HOST=""
ENV SSHFS_PORT="22"
ENV SSHFS_LOCAL_PATH=""
ENV SSHFS_HOST_PATH=""
ENV SSH_CONFIG_DIR=""

RUN add-pkg sshfs fuse3 nano
RUN mkdir -p -m 0600 /mnt/files
COPY ./build_files/startapp.sh /startapp.sh
COPY ./build_files/fuse.conf /etc/