Identity Management
===================

.. toctree::
   :maxdepth: 1

   ipaserver


Identity can be managed in the following ways in the junkco environment:

* IPA Server (CentOS 7)
* Manual Addition to the database via script
* Spacewalk server (untested)

**IPA Server**

Install via print instructions (TODO: see white binder and add this)
Additional configuration can be found in the centos/ipaserver section of github

**Unique Identifiers**

The Users table is a table in the Junkco database which is a component of the environment. In order to ensure that identities are unique a simple python script is provided in the junkco/etc/idmanager/ directory.

``$ python generate_user.py``

This will generate an application unique seven-digit number for use in the database. The value will be added to the **existing_entries.dat** file that resides in the idmanager directory.

.. Warning::
   To ensure consistency across all environments, maintain a local copy of the exsiting_entries.dat file. 

.. tip::
   You must create an empty existing_entries.dat file in a new installation or the generate_user.py script will fail.
