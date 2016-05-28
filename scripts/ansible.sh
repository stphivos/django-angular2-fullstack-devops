#!/usr/bin/env bash

apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible-2.0 apt-get update
#apt-get install -y ansible

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install ansible boto awscli
