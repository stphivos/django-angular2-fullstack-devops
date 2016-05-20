#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y software-properties-common git libffi-dev libssl-dev build-essential python-dev
apt-add-repository -y ppa:ansible/ansible-2.0 apt-get update

#ssh-keyscan github.com > /etc/ssh/ssh_known_hosts
#git clone git@github.com:stphivos/django-angular2-fullstack-compact.git

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install ansible boto awscli

#echo '%sudo    ALL=(ALL)  NOPASSWD:ALL' >> /etc/sudoers

#mkdir -p ${SERVER_ROOT_PATH}
#cd ${SERVER_ROOT_PATH}
#ssh-keyscan github.com >> ~/.ssh/known_hosts
#git clone ${GIT_REPO} ${APPLICATION_NAME}
