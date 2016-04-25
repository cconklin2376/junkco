IPA Server
==========

Initial install performed  Jan 29, 2016

Steps:

1. Install CentOS 7 with server gui pattern with at least 2 GB of RAM
2. # yum install -y ipa-server bind bind-dyndb-ldap (ipa-server-dns is needed too!)
3. # ipa-server-install

Go with the DNS. Just go with it!

.. Warning: see the problem with the local ip below. It works after commenting out that code.
   then follow the next steps provided.


The first annoying thing was that the tutorial mentions creating an entry in the /etc/hosts file for the server. If you do this the install will fail as the installer populates the hosts file. It may overwrite instead of conflict (I had the issue with the ip address so I don't know what it does but the point is that you don't have to set it.)

Another biggie is your ip address. I was going to use my internal scheme and have the ipa.example.com resolve to 192.168.122.11 BUT the installer checks for local addresses. The workaround is to hack the python code!
via: https://www.redhat.com/archives/freeipa-users/2012-February/msg00064.html

The workaround:
/usr/lib/python2.6/site-packages/ipapython/ipautil.py line 145  as below.. remark all 4 lines and it'll continue

    """
    if addr == net.network:
    raise ValueError("cannot use IP network address")
    if addr.version == 4 and addr == net.broadcast:
    raise ValueError("cannot use broadcast IP address")
    """


Firewall Entries::

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

Amazing!

Client can be installed with ipa-client-install

see near bottom:
http://blog.christophersmart.com/articles/freeipa-how-to-fedora/
External resources:
Cert Depot Entry on IPA setup on CentOS 7 `a link`_.

.. _a link: https://www.certdepot.net/rhel7-configure-freeipa-server/

`Unixmen Config IPA Server <http://www.unixmen.com/configure-freeipa-server-centos-7/>`_



ipa-client-install on centos 7
