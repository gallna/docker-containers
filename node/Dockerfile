FROM ubuntu:15.04
MAINTAINER Tomasz Jonik <tomasz@hurricane.works>

# Install npm
RUN apt-get update \
    && apt-get install -y node npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix node
RUN rm /usr/sbin/node \
    && ln -s /usr/bin/nodejs /usr/sbin/node
