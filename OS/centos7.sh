#!/bin/bash

set -e
printf '\nInstalling on CentOS Linux 7\n\n'

### Generate docker config
printf '\nPrepare config for overlay2...\n\n'
mkdir /etc/docker
touch /etc/docker/daemon.json

echo '{
    "log-driver": "json-file",
        "log-opts": {
    "max-size": "10m",    
    "max-file": "5"    
    },
    "dns": ["1.1.1.1"],
    "bip": "172.26.0.1/16",
    "live-restore": true,
	  "storage-driver": "overlay2",
	  "storage-opts": [
 	   "overlay2.override_kernel_check=true"
	    ]
	  }' > /etc/docker/daemon.json

touch /etc/sysctl.d/docker.conf
echo 'net.ipv6.conf.default.accept_ra_rtr_pref = 0
	net.ipv6.conf.default.accept_ra_pinfo = 0
	net.ipv6.conf.default.accept_ra_defrtr = 0
	net.ipv6.conf.default.autoconf = 0
	net.ipv6.conf.default.dad_transmits = 0
	net.ipv6.conf.default.max_addresses = 1
	net.bridge.bridge-nf-call-ip6tables = 1
	net.bridge.bridge-nf-call-iptables = 1
' > /etc/sysctl.d/docker.conf
sysctl -p

### Docker install
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

systemctl start docker
systemctl enable docker
usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

printf '\n====YOU NEED TO REBOOT SERVER====\n\n'

exit 0
