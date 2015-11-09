#!/bin/bash

###############################################################################
# Spacewalk Server Install on CentOS 7
#
# Modified from: 
#      http://jensd.be/566/linux/install-and-use-spacewalk-2-3-on-centos-7
#
# Errata config from: http://cefs.steve-meier.de/
# 
###############################################################################

SWK_USER=$(whoami)
SWK_USER_HOME=/home/$SPACEWALK_USER
SYS_IP="`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`"
SWK_ADMIN="admin"

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

yum install -y epel-release

###############################################################################
# Configure Repo
###############################################################################

cat > /etc/yum.repos.d/jpackage-generic.repo << EOF
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
rpm -Uvh http://yum.spacewalkproject.org/2.4/RHEL/7/x86_64/spacewalk-repo-2.4-3.el7.noarch.rpm

yum install -y spacewalk-setup-postgresql


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

sudo yum install -y spacewalk-postgresql

sudo spacewalk-setup --disconnected


###############################################################################
# Errata config 
###############################################################################
# consider using user home .spacewalk-errata directory instead?
sudo yum install -y wget

#mkdir -p /var/lib/spacewalk-errata && cd /var/lib/spacewalk-errata
mkdir $SWK_USER_HOME/.spacewalk-errata 
cd $SWK_USER_HOME/.spacewalk-errata

wget http://cefs.steve-meier.de/errata.latest.xml
wget http://cefs.steve-meier.de/errata-import.tar

tar xf errata-import.tar

chmod 775 errata-import.pl

sudo yum install -y perl-Frontier-RPC
sudo yum install -y perl-Text-Unidecode  

EFILE=$SWK_USER_HOME/.spacewalk-errata/errata-latest.xml

# usage: ./errata-import.pl --server <SERVER> --errata <ERRATA_FILE>
$SWK_USER_HOME/.spacewalk-errata/errata-import.pl --server $SYS_IP --errata $EFILE

cat <<UPDT > $SWK_USER_HOME/.spacewalk-errata/check-update.sh
/usr/bin/wget -N http://cefs.steve-meier.de/errata.latest.xml
UPDT

chmod 775 $SWK_USER_HOME/.spacewalk-errata/check-update.sh

###############################################################################
# Cron Jobs
###############################################################################
if [ ! -f /etc/cron.d/$SWK_USER ]; then
    cat > /etc/cron.d/$SWK_USER <<CRON
0    3 * * * $SWK_USER_HOME/.spacewalk-errata/check-update.sh
CRON











