#!/bin/bash

set -e
printf '\nInstalling on Ubuntu 20.04\n\n'

### Generate docker config
printf '\nPrepare config for overlay2...\n\n'

if [ -e /etc/docker ]
then printf '\nDocker directory already exist\n\n'
else mkdir /etc/docker
fi
 
if [ -e /etc/docker/daemon.json ]
then printf '\nDocker config already exist, renaming\n\n' && mv /etc/docker/daemon.json /etc/docker/daemon.json.OLD
else touch /etc/docker/daemon.json
fi

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

### Changes in GRUB config
printf '\nTuning GRUB config...\n\n'
sed -i 's/GRUB_CMDLINE_LINUX\s*=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
update-grub

### Docker install
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

if [ -e /usr/bin/docker-compose ]
then printf '\nUpdating docker-compose\n\n' && rm -rf /usr/bin/docker-compose
else ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

printf '\n====YOU NEED TO REBOOT SERVER====\n\n'

exit 0
