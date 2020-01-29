#!/bin/bash

bootstrap() {
    echo "Bootstrap Ansible ..."

    if [[ $EUID -eq 0 ]]; then
        echo "Enable sudo ..."
        if [ -f /etc/debian_version ] ; then
            apt-get update -y && apt-get install -y sudo
        elif [ -f /etc/redhat-release ] ; then
            yum update -y && yum install -y sudo
        fi
    fi

    if [ -f /etc/debian_version ] ; then
        echo "Install Debian/Ubuntu packages ..."
        sudo apt-get update -y
        sudo apt-get install -y software-properties-common build-essential
        # install ansible
        sudo apt-add-repository -y ppa:ansible/ansible
        sudo apt-get update -y
        sudo apt-get install -y ansible
        # sudo apt-get install -y vim-common # anaconda needs xxd
    elif [ -f /etc/redhat-release ] ; then
        echo "Install RedHat/CentOS packages ..."
        sudo yum update -y
        sudo yum install -y epel-release
        sudo yum install -y gcc-c++ make
        sudo yum install -y ansible
    elif [ `uname -s` = "Darwin" ] ; then
        echo "Install Homebrew packages ..."
        # Temporary workaround to Python bug in macOS High Sierra which can break Ansible
        # https://github.com/ansible/ansible/issues/34056#issuecomment-352862252
        export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
        brew install ansible
    fi
}


bootstrap
