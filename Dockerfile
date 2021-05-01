FROM ubuntu:focal

ARG UNAME=ya
ARG UID=1000
ARG GID=1000

# install applications
RUN apt-get update
RUN apt-get install -y \
    sudo build-essential file wget cpio unzip rsync bc locales libncurses-dev vim python3

# set the locale
RUN locale-gen en_US.UTF-8
RUN update-locale 

# create new user
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash -G sudo $UNAME
# set root password
RUN echo "$UNAME:root" | chpasswd

USER $UNAME
WORKDIR /home/$UNAME/src
