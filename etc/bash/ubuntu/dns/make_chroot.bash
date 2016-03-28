#!/bin/bash

# from linux web operations video
# you will also need to edit the bind9 options and tell bind where the
# chroot is
# OPTIONS="-u bind -4 -t /var/named -t /chroot/named -c /etc/bind/named.conf"
# will use chroot named but still will use original named.conf 

chroot_base=/chroot/named

mkdir -p ${chroot_base}{,/dev,/etc/namedb/slave,/var/run/,/var/cache/bind,/etc/bind}
chown root:root /chroot
chmod 700 /chroot
chown -R bind:bind $chroot_base
chmod 700 $chroot_base

chown bind:bind /chroot/named/etc/namedb/slave

mknod ${chroot_base}/dev/null c 1 3
mknod ${chroot_base}/dev/random c 1 8

cp /etc/bind/{db,named.conf,rndc}* ${chroot_base}/etc/bind

mkdir -p ${chroot_base}/usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/
cp /usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libgost.so ${chroot_base}/usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/

