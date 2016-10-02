#!/bin/bash -e

echo "Update/upgrade box"
apt-get update
apt-get upgrade -y

echo "Install essentials"
apt-get install -y build-essential libssl-dev libffi-dev python-dev git

echo "Add ansible software sources"
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
