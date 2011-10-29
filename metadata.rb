maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs Alfresco Community Edition."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

recipe "alfresco", "Installs Alfresco Community Edition."

supports "ubuntu"

depends "imagemagick"
depends "java"
depends "mysql"
depends "database"
depends "openoffice"
depends "swftools"
depends "tomcat"
