#!/usr/bin/env bash

# Docker
if [ ! -x "$(command -v docker)" ]; then
    echo "Installing docker-ce ..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    apt-get update
    apt-get install -y docker-ce
    usermod -aG docker vagrant
fi

# Install jq (Used for parsing the current STABLE, DEV, BETA release versions)
if [ ! -x "$(command -v jq)" ]; then
    echo "Installing jq ..."
    apt-get install -y jq
fi

# Install depot_tools
if [ ! -d "/depot_tools" ]; then
    echo "Installing depot_tools ..."
    cd /
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
    echo "PATH=\"/depot_tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" > /etc/environment
    chmod 0777 -R /depot_tools
fi

# Libv8 builds
apt-get install -y build-essential curl git python libglib2.0-dev 
