Server Configuration
====================

We are currently running a mixture of Vagrant boxes, Bare Metal Servers, and VMs. Each server role should have a workflow in one or more environments. 

Vagrant Environments
--------------------
* Ubuntu 14.04
   * `Mossy Lab Basic LAMP Server <https://github.com/chris-conklin/mossy_lab>`_


Traditional Base Install and Config Script
------------------------------------------
* CentOS 7
   * `A general LAMP server <https://github.com/chris-conklin/junkco/blob/master/etc/bash/centos7/base-servers/junkco_installer>`_
   * `A more specific LAMP server <https://github.com/chris-conklin/junkco/blob/master/etc/bash/centos7/base-servers/junkco_installer>`_
   * `A Spacewalk server <https://github.com/chris-conklin/junkco/tree/master/etc/bash/centos7/spacewalk>`_

* Ubuntu 14.04
   * `A dns server (master only) <https://github.com/chris-conklin/junkco/tree/master/etc/bash/ubuntu/dns>`_
   * `A monitor server (carbon) <https://github.com/chris-conklin/junkco/tree/master/etc/bash/ubuntu/monitor>`_
   
* XUbuntu 14
   * `Persistent Server Script-out <TODO>`_


