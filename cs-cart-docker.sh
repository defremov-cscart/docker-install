#!/bin/bash
### Check OS version
set -e
 if cat /etc/*release | grep ^PRETTY_NAME | grep "Ubuntu 16.04"; then
    printf '\nInstalling on Ubuntu 16.04\n\n'

apt-get -qq update -y > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/ubuntu16.sh" -o ubuntu16.sh
sh ubuntu16.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "Ubuntu 18.04"; then
    printf '\nInstalling on Ubuntu 18.04\n\n' 

apt-get -qq update -y > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/ubuntu18.sh" -o ubuntu18.sh
sh ubuntu18.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "Ubuntu 20.04"; then
    printf '\nInstalling on Ubuntu 20.04\n\n' 

apt-get -qq update -y > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/ubuntu20.sh" -o ubuntu20.sh
sh ubuntu20.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "CentOS Linux 7"; then
    printf '\nInstalling on CentOS Linux 7\n\n' 

### Installing packages
printf '\nInstalling packages...\n\n'
yum install -q -y yum-utils \
    device-mapper-persistent-data \
    lvm2 \
    make \
    deltarpm  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/centos7.sh" -o centos7.sh
sh centos7.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "Ubuntu 21.04"; then
    printf '\nInstalling on Ubuntu 21.04\n\n'

apt-get -qq update -y > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/ubuntu21.sh" -o ubuntu21.sh
sh ubuntu21.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "CentOS Linux 8"; then
    printf '\nInstalling on CentOS Linux 8\n\n' 

### Installing packages
printf '\nInstalling packages...\n\n'
yum install -q -y yum-utils \
    device-mapper-persistent-data \
    make \
    lvm2  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/centos8.sh" -o centos8.sh
sh centos8.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "Debian GNU/Linux 10"; then
    printf '\nInstalling on Debian GNU/Linux 10\n\n' 

apt-get -qq update -y  > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/debian10.sh" -o debian10.sh
sh debian10.sh

elif cat /etc/*release | grep ^PRETTY_NAME | grep "Debian GNU/Linux 11"; then
    printf '\nInstalling on Debian GNU/Linux 11\n\n' 

apt-get -qq update -y  > /dev/null
apt -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    make \
    gnupg-agent \
    software-properties-common  > /dev/null

curl -fsSL "https://raw.githubusercontent.com/defremov-cscart/docker-install/main/OS/debian11.sh" -o debian11.sh
sh debian11.sh

else
   printf '\nWRONG OS VERSION\n\n'
   exit 1;
fi

exit 0
