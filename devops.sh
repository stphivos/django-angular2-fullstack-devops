#!/usr/bin/env bash

env=$2

export SERVER_ROOT_NAME=webapps
export APPLICATION_NAME=fullstack
export PROJECT_NAME=backend
export GIT_REPO=git@github.com:stphivos/django-angular2-fullstack-compact.git
export GIT_BRANCH=dev

export SERVER_ROOT_PATH=/${SERVER_ROOT_NAME}
export VIRTUALENV_PATH=${SERVER_ROOT_PATH}/${APPLICATION_NAME}
export PROJECT_PATH=${VIRTUALENV_PATH}/${PROJECT_NAME}

build() {
   cd provisioning/packer
   packer build ${env}.json
}

# call arguments verbatim:
$@
