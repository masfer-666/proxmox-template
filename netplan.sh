#!/bin/bash
#
# Creates a backup
cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak_`date +%Y%m%d%H%M`
# Retrieves the NIC information
nic=`ifconfig | awk 'NR==1{print $1}'`
# Ask for input on network configuration
read -p "Masukan static IP Server: " staticip
read -p "Masukan IP of gateway: " gatewayip
read -p "Masukan IP of dns server (seperated by a coma if more than one): " nameserversip
read -p "Masukan Hostname: " hostname
echo
cat > /etc/netplan/00-installer-config.yaml <<EOF

network:
  ethernets:
    $nic
      addresses:
        - $staticip/24
      gateway4: $gatewayip
      nameservers:
        addresses:
          - $nameserversip
        search: []
  version: 2
          
EOF
sudo netplan apply
hostnamectl set-hostname $hostname
echo "==========================="
echo

