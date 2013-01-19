maintainer       "Nathan Mische"
maintainer_email "nmische@gmail.com"
license          "Apache 2.0"
description      "Sets up ColdFire development environment."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

supports "ubuntu"

depends "ant"
depends "coldfusion10"
depends "mysql"
depends "railo334"

recipe "coldfire-dev", "Downloads ColdFire to the ColdFusion webroot and configures the server for development and testing."


