#!/bin/bash

REMOTE_REPO="to-do"
REPO_NAME="to-do"

function main() {
    cd /tmp/
    
    git clone $REMOTE_REPO

    cd $REPO_NAME

    cp -rf src/code /etc/puppetlabs/code

    ssh root@client 'puppet agent -t'
}

main