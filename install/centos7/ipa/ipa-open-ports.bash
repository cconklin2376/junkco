#!/bin/bash

# http/https
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
# ldap/ldaps
firewall-cmd --zone=public --add-port=398/tcp --permanent
firewall-cmd --zone=public --add-port=636/tcp --permanent
# kerberos
firewall-cmd --zone=public --add-port=88/tcp --permanent
firewall-cmd --zone=public --add-port=464/tcp --permanent
# bind
firewall-cmd --zone=public --add-port=53/tcp --permanent

# kerberos
firewall-cmd --zone=public --add-port=88/udp --permanent
firewall-cmd --zone=public --add-port=464/udp --permanent
# bind
firewall-cmd --zone=public --add-port=53/udp --permanent
# ntp
firewall-cmd --zone=public --add-port=123/udp --permanent
