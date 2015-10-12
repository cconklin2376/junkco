#!/bin/bash

###############################################################################
# JunkCo samba setup script
# For use with CentOS/RHEL 7
# 10-12-15
# Prereqs: Run installer script first
###############################################################################

set -e

###############################################################################
# Configuration
###############################################################################
# the server environment you are setting up dev or prod
SRVENV='dev'

# which user to install the code for; defaults to the user invoking this script
JUNKCO_USER=${JUNKCO_USER:-$SUDO_USER}

# the group to run junkco code as; must exist already
JUNKCO_GROUP=${JUNKCO_GROUP:-nogroup}

# the root directory to base the install in. must exist already
JUNKCO_HOME=${JUNKCO_HOME:-/home/$JUNKCO_USER}

# the domain that you will connect to your reddit install with.
# MUST contain a . in it somewhere as browsers won't do cookies for dotless
# domains. an IP address will suffice if nothing else is available.
JUNKCO_DOMAIN=${JUNKCO_DOMAIN:-junkco$SRVENV.local}

SYS_IP="`ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'`"

YUM_OPTIONS="-y"

WKGRP='HOMENET'  

###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi

set -x

###############################################################################
# Install 
###############################################################################

yum install $YUM_OPTIONS samba samba-client samba-common

mv /etc/samba/smb.conf /etc/samba/smb.conf.bak

cat > /etc/samba/smb.conf <<SCONF

[global]
workgroup = $WKGRP
server string = Samba Server %v
netbios name = centos
security = user
map to guest = bad user
dns proxy = no
#============================ Share Definitions ============================== 
[webroot]
path = /var/www
browsable =yes
writable = yes
guest ok = yes
read only = no

SCONF


