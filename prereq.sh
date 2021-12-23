#!/bin/bash

# PYTHON_VERSION='3.6.13'
OPENSHIFT_VERSION='0.11.0'

echo "Initiating Prerequisite Setup "

sudo apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        wget\
        curl \
        unzip \
        build-essential \
        openjdk-14-jdk \
	    openssh-client \
        gcc \
        git \
        libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev \
        jq \
        npm

echo "Installing Python Packages"

sudo apt-get update && apt-get install -y \
    python3-pip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    pip3 install ansible && \
    pip3 install jmespath && \
    pip3 install openshift==${OPENSHIFT_VERSION} && \
    apt-get clean && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

npm install -g ajv-cli

sudo apt-get update

echo "Completeing Installation"