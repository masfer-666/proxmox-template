#!/bin/bash
# generate machine id
systemd-machine-id-setup
# remove ssh host keys
sudo rm -f /etc/ssh/ssh_host_*
# generate ssh key
ssh-keygen -A && service ssh --full-restart
sleep 1
# generate password root
passwd root
sleep 1
#Set IP SERVER
cd "$(pwd)"; sh netplan.sh
# truncate the machine-id file
sudo truncate -s 0 /etc/machine-id
# delete source script
rm -rf /opt/proxmox-template
