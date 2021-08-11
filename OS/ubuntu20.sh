#!/bin/bash

set -e
printf '\nInstalling on Ubuntu 20.04\n\n'

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

### Changes in GRUB config
printf '\nTuning GRUB config...\n\n'
sed -i 's/GRUB_CMDLINE_LINUX\s*=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
update-grub

### Docker install
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

printf '\n====YOU NEED TO REBOOT SERVER====\n\n'

exit 0
