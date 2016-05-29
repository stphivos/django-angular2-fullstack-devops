#!/usr/bin/env bash

echo "" > /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty main restricted" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty main restricted" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main restricted" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty-updates main restricted" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty-updates universe" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty-updates universe" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty-updates multiverse" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security main" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu trusty-security main" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security universe" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu trusty-security universe" >> /etc/apt/sources.list


apt-get update
apt-get upgrade -y

apt-get install -y build-essential libssl-dev libffi-dev python-dev git
