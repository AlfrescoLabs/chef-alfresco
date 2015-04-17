name             "alfresco"
maintainer       "Maurizio Pillitu"
maintainer_email ""
license          "Apache 2.0"
description      "Installs Alfresco Community and Enterprise Edition."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5.0"

# Resolved by Berkshelf, not present in Supermarket or forked
depends "file"
depends "tomcat"
depends "maven"

# Community cookbooks
depends "artifact-deployer", "~> 0.8.7"
depends "imagemagick", "~> 0.2.3"
depends "java", "~> 1.31.0"
depends "mysql", "~> 6.0.21"
depends 'mysql2_chef_gem', "~> 1.0.1"
depends "database", "~> 4.0.5"
depends "openoffice", "~> 0.2.2"
depends "swftools", "~> 0.2.4"
depends "haproxy", "~> 1.6.6"
depends "nginx", "~> 2.7.6"
depends 'build-essential', '~> 2.2.3'
depends 'yum-epel', '~> 0.6.0'
