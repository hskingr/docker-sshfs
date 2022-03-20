FROM ubuntu:20.04
LABEL maintainer="@jaydrogers"

# set version for s6 overlay
ARG OVERLAY_VERSION="v2.2.0.3"
ARG OVERLAY_ARCH="amd64"

# add s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}-installer /tmp/
RUN chmod +x /tmp/s6-overlay-${OVERLAY_ARCH}-installer && /tmp/s6-overlay-${OVERLAY_ARCH}-installer / && rm /tmp/s6-overlay-${OVERLAY_ARCH}-installer

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/root" 
ENV SSHFS_USER=""
ENV SSHFS_HOST=""
ENV SSHFS_PORT="22"
ENV SSHFS_LOCAL_PATH="" 
ENV SSHFS_HOST_PATH="" \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
TERM="xterm"

ENTRYPOINT ["/init"]

RUN apt-get update && apt-get install sshfs fuse3 nano -y 
RUN mkdir -p -m 0600 /mnt/files
COPY ./build_files/fuse.conf /etc/
COPY ./build_files/etc /etc