#!/bin/bash
###############################################################################
# install-ub14-carbon-monitor-server.sh
# this borrows heavily from:
# https://www.digitalocean.com/community/tutorials/how-to-configure-collectd-to-gather-system-metrics-for-graphite-on-ubuntu-14-04
# and
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-graphite-on-an-ubuntu-14-04-server
# March 16, 2016
#
# It turns out that this is pretty hard to automate right now. It might be
# more beneficial to move right into an ansible playbook and skip the 
# old school way. I'll leave this here as a placeholder for now to reference
# the links. There are a ton of Stack Overflow hits on psql command line stuff.
###############################################################################


###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi

#if [[ -z "$PGPASSWD" ]]; then
#	echo "USAGE: You must set postgresql password in env var PGPASSWD"
#	exit 1
#fi

###############################################################################
# Install prerequisites
###############################################################################
set -x

# aptitude configuration
APTITUDE_OPTIONS="-y"
export DEBIAN_FRONTEND=noninteractive

# run an aptitude update to make sure python-software-properties
# dependencies are found
apt-get update

# install prerequisites
cat <<PACKAGES | xargs apt-get install $APTITUDE_OPTIONS
git-core
graphite-web 
graphite-carbon
postgresql 
libpq-dev 
python-psycopg2
collectd
collectd-utils
PACKAGES


