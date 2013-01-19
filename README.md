DESCRIPTION
===========

Installs ColdFire for local development. This cookbook assumes a Vagrant box with ColdFusion 10 and Railo 3.3.4 Express and MySQL Sever.

REQUIREMENTS
============

* coldfusion10
* railo334
* ant
* mysql (server and client)

ATTRIBUTES
==========

* `node['coldfire-dev']['git']['repository']` - Path to ColdFire git repo (default: "git@github.com:nmische/ColdFire.git")
* `node['coldfire-dev']['git']['revision']` - Revison to checkout (default: "master")
* `node['coldfire-dev']['git']['deployment_key']` - SSH key to use to clone the ColdFire repo. The value may also be set via a data bag. For more info see Deployment Key below.

DEPLOYMENT KEY
==============

Inorder to clone the ColdFire repo you must supply a deployment key. (See: http://wiki.opscode.com/display/chef/Deploy+Resource#DeployResource-PrivateDeployExample).
You can either supply this key via a node attribute or via a data bag item. For Chef Solo you can use a normal data bag and for Hosted Chef you can use an encrypted data bag. In either case the data bag should be named "deployment_keys" and it should have an item named "coldfire." Below is a sample data bag:

    { 
      "id" : "coldfire",
      "deployment_key" : "-----BEGIN RSA PRIVATE KEY-----\nABC...TRUNCATED...123\n-----END RSA PRIVATE KEY-----\n"
    }
