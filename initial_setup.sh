#!/bin/bash

HOSTNAME=$(hostname)
REQUIRED_TOOLS="git curl wget"

PUPPET_VERSION="puppet7"
PUPPET_REPO="https://apt.puppet.com/$PUPPET_VERSION-release-$(lsb_release -c --short).deb"

function stage_zero() {
    echo "#### Starting stage 0: ... ####"
    
    #update pkg manager
    apt update -y
    apt install -y $REQUIRED_TOOLS

    # Configure timezone
    timedatectl set-timezone Europe/Lisbon

    echo "#### Stage 0 completed succesfully ###"


}

function stage_one() {
    echo "#### Starting stage 1: ... ####"

    wget $PUPPET_REPO
    dpkg -i *.deb
    apt update -y

    if [[ $HOSTNAME == 'master' ]]
    then
        apt-get install -y puppetserver
    else
        apt-get install -y puppet-agent
    fi

    #add puppet bins to root path 
    echo 'PATH=$PATH:/opt/puppetlabs/bin' >> /root/.bashrc

    source /root/.bashrc

    echo "#### Stage 1 completed succesfully ###"
}

function setup_master() {
    echo '192.168.2.101     puppet' >> /etc/hosts
    echo '192.168.2.101     master' >> /etc/hosts
    echo '192.168.2.101     client' >> /etc/hosts

    sed -i.bkp 's/-Xms2g -Xmx2g/-Xms1g -Xmx1g/g' /etc/default/puppetserver

    rm -r /etc/puppetlabs/code

    cp -r /vagrant/src/code /etc/puppetlabs/

    systemctl enable puppetserver

    systemctl start puppetserver
}

function setup_agent() {

    echo '192.168.2.100     master' >> /etc/hosts
    
    puppet resource service puppet ensure=running enable=true

    puppet config set server master --section main

}


function main() {
    stage_zero   
    stage_one

    if [[ $HOSTNAME == 'master' ]]
    then
        setup_master
    else
        setup_agent
    fi
}

main