#!/bin/bash

###############################################################################
# Spacewalk Server errata config on CentOS 7
#
#
# Errata config from: http://cefs.steve-meier.de/
# Run after spacewalk server is configured
##############################################################################

#SCRIPT_USR=$(whoami)
SCRIPT_USR=tester
SCRIPT_USR_HOME=/home/$SCRIPT_USR
SYS_IP="`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`"
export SPACEWALK_USER=$1
export SPACEWALK_PASS=$2
###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi

if [ -z ${1} ] || [ -z ${2} ]; then
    echo "Usage: script username password"
    exit 1
fi

###############################################################################
# Errata config 
###############################################################################
# consider using user home .spacewalk-errata directory instead?
sudo yum install -y wget

#mkdir -p /var/lib/spacewalk-errata && cd /var/lib/spacewalk-errata
mkdir $SCRIPT_USR_HOME/.spacewalk-errata 
cd $SCRIPT_USR_HOME/.spacewalk-errata

wget -N http://cefs.steve-meier.de/errata.latest.xml
wget http://cefs.steve-meier.de/errata-import.tar

tar xf errata-import.tar

chmod 775 errata-import.pl

sudo yum install -y perl-Frontier-RPC
sudo yum install -y perl-Text-Unidecode  

EFILE=$SCRIPT_USR_HOME/.spacewalk-errata/errata.latest.xml

# usage: ./errata-import.pl --server <SERVER> --errata <ERRATA_FILE>
$SCRIPT_USR_HOME/.spacewalk-errata/errata-import.pl --server $SYS_IP --errata $EFILE

cat <<UPDT > $SCRIPT_USR_HOME/.spacewalk-errata/check-update.sh
/usr/bin/wget -N http://cefs.steve-meier.de/errata.latest.xml
UPDT

chmod 775 $SCRIPT_USR_HOME/.spacewalk-errata/check-update.sh

###############################################################################
# Cron Jobs
###############################################################################
if [ ! -f /etc/cron.d/$SCRIPT_USR ]; then
    cat > /etc/cron.d/$SCRIPT_USR <<CRON
0    3 * * * $SCRIPT_USR_HOME/.spacewalk-errata/check-update.sh
CRON
