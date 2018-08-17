FROM ubuntu:16.04

LABEL maintainer="Mark Johnson <https://github.com/virgofx>"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV PATH /depot_tools:"$PATH"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential curl git python libglib2.0-dev && \
    cd / && \
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home