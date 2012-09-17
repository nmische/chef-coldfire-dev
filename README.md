DESCRIPTION
===========

Installs ColdFire for local development. This cookbook assumes a Vagrant box with ColdFusion 9.0.2 Standalone and Railo 3.3.4 Express and MySQL Sever.

REQUIREMENTS
============

* coldfusion902
* railo334
* ant
* mysql (server and client)

ATTRIBUTES
==========

* `node['coldfire']['git']['repository']` - Path to ColdFire git repo (default: "git@github.com:nmische/ColdFire.git")
* `node['coldfire']['git']['revision']` - Revison to checkout (default: "master")