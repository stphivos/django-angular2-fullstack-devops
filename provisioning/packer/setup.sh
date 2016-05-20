#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y build-essential libssl-dev libffi-dev python-dev git
apt-add-repository -y ppa:ansible/ansible-2.0 apt-get update

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install ansible boto awscli
