#!/bin/bash

###############################################################################
# Spacewalk Server errata config on CentOS 7
#
#
# Errata config from: http://cefs.steve-meier.de/
# Run after spacewalk server is configured
##############################################################################

#SWK_USER=$(whoami)
SWK_USER=tester
SWK_USER_HOME=/home/$SWK_USER
SYS_IP="`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`"
SWK_ADMIN="admin"

###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi


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











