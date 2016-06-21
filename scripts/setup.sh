#!/bin/sh -e

echo "Update/upgrade box"
apt-get update
apt-get upgrade -y

echo "Install essentials"
apt-get install -y build-essential libssl-dev libffi-dev python-dev git
