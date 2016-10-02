#!/bin/bash -e

cmd=$1

install() {
    app=$1
    echo "devops needs to install '${app}' using sudo with the following commands:"
    echo ""

    for x in "$@"; do if [[ ${x} != ${app} ]]; then echo "$ "${x}; fi done

    echo ""
    read -p "if you wish to do it manually exit using ctrl-c otherwise press enter to continue (you may be asked for password)..."
    echo ""

    for x in "$@"; do if [[ ${x} != ${app} ]]; then echo "Installing ${app}..."; sudo bash -c "${x}"; fi done
    echo ""
}

if [[ -z ${cmd} || ${cmd} == "pip" ]]; then
    install "python-pip" "wget https://bootstrap.pypa.io/get-pip.py" "python get-pip.py" "rm -f get-pip.py"
fi

if [[ -z ${cmd} || ${cmd} == "ansible" ]]; then
    install "ansible" "pip install ansible"
fi

if [[ -z ${cmd} || ${cmd} == "aws" ]]; then
    install "awscli" "pip install awscli"
fi
