#!/bin/bash

REMOTE_DIR="/etc/puppetlabs"
LOCAL_CODE="/vagrant/src/code"



function main() {
    vagrant rsync master

    vagrant ssh master -c "sudo rm -r $REMOTE_DIR/code"

    vagrant ssh master -c "sudo cp -r $LOCAL_CODE $REMOTE_DIR/"

    #vagrant ssh master -c "sudo /opt/puppetlabs/bin/puppet agent -t"

    vagrant ssh client -c "sudo /opt/puppetlabs/bin/puppet agent -t"
}

main


# don't forget to chmod +x