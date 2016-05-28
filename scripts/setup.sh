#!/usr/bin/env bash

echo "deb http://archive.ubuntu.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list

apt-get update
apt-get upgrade -y

apt-get install -y build-essential libssl-dev libffi-dev python-dev git
