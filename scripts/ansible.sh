#!/bin/bash -e

echo "Add ansible software sources"
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible-2.0 apt-get update

echo "Install python pip"
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

echo "Install ansible"
pip install ansible boto awscli
