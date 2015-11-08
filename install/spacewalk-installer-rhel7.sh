#!/bin/bash

###############################################################################
# Spacewalk Server Install on CentOS 7
#
# Modified from: 
#      http://jensd.be/566/linux/install-and-use-spacewalk-2-3-on-centos-7
# 
###############################################################################


###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi

set -x

###############################################################################
# Install Epel
###############################################################################

yum install epel-release

###############################################################################
# Configure Repo
###############################################################################

cat sudo tee /etc/yum.repos.d/jpackage-generic.repo << EOF
[jpackage-generic]
name=JPackage generic
#baseurl=http://mirrors.dotsrc.org/pub/jpackage/5.0/generic/free/
mirrorlist=http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0
enabled=1
gpgcheck=1
gpgkey=http://www.jpackage.org/jpackage.asc
EOF

###############################################################################
# Install
###############################################################################
yum install http://yum.spacewalkproject.org/2.3/RHEL/7/x86_64/spacewalk-repo-2.3-2.el7.noarch.rpm

yum install spacewalk-setup-postgresql


###############################################################################
# Firewall
###############################################################################

sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload

# ping $(hostname -f) -c1

###############################################################################
# Spacewalk Installation
###############################################################################

sudo yum install spacewalk-postgresql

sudo spacewalk-setup --disconnected














