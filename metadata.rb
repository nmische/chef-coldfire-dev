maintainer       "Nathan Mische"
maintainer_email "nmische@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures ColdFusion 9.0.2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

supports 'ubuntu', '>= 12.04'

depends "coldfusion902"

recipe "coldfire-dev", "Downloads ColdFire to the ColdFusion webroot and configures the server for development and testing."


