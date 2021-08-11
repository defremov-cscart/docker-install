#!/bin/bash

set -e
printf '\nInstalling on CentOS Linux 7\n\n'

### Generate docker config
printf '\nPrepare config for overlay2...\n\n'
mkdir /etc/docker
touch /etc/docker/daemon.json

echo '{
    "dns": ["1.1.1.1"],
    "default-address-pools": [{
		  "base": "172.100.0.0/8",
		  "size": 16
	  }],
    "live-restore": true,
	  "storage-driver": "overlay2",
	  "storage-opts": [
 	   "overlay2.override_kernel_check=true"
	    ]
	  }' > /etc/docker/daemon.json
    
### Installing packages
printf '\nInstalling packages...\n\n'
yum install -q -y yum-utils \
    device-mapper-persistent-data \
    lvm2

### Docker install
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

printf '\n====YOU NEED TO REBOOT SERVER====\n\n'

exit 0
