#!/bin/bash -e

HOME=$(pwd)

echo "Setup bashrc"
printf "\n# ${APPLICATION_NAME}
source ${VIRTUALENV_PATH}/bin/activate
source ${VIRTUALENV_PATH}/bin/postactivate
cd ${HOME}/${APPLICATION_NAME}
" >> ${HOME}/.bashrc

echo "Clone git repo"
mkdir -p ${SERVER_ROOT_PATH}
cd ${SERVER_ROOT_PATH}
ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts
git clone -b ${GIT_BRANCH} --single-branch ${GIT_REPO} ${APPLICATION_NAME}
groupadd ${SERVER_ROOT_NAME}
chown -R vagrant:${SERVER_ROOT_NAME} ${APPLICATION_PATH}
