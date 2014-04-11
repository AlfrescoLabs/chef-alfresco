Introduction
========
chef-alfresco is a collection of recipes that provide a modular way to install Alfresco using Chef.
There is no default recipe in chef-alfresco; here follows the complete list:
* build_tools - Contains tools (apt, nokogiri and chef-rewind) that are needed during the installation process of some Chef resources
* 3rdparty - Contains the tools that provide transformation features to Alfresco Repository (TODO, should be called 'transformation')
* java_tools - Contains JDK and Maven 3; it also handles the settings.xml setup, in case of an Enterprise installation
* mysql_server - Install MySQL5 and grants access to ```node['alfresco']['db']['repo_hosts']```
* repository - Fetches and/or installs Alfresco Repository WAR; it also handles log4j.properties and alfresco-global.properties patching
* share - Fetches and/or installs Alfresco Share WAR; it also handles log4j.properties patching
* solr - Fetches and/or installs Alfresco Solr Banduru; it also handles log4j.properties and solr configuration patching
* tomcat - Installs (a 'rewinded') Apache Tomcat (that won't start after the installation; it will be restarted on each repo/share/solr redeployment)

Installation
========
If you want to use chef-alfresco in a chef recipe/cookbook, please refer to the [original project page](https://github.com/fnichol/chef-alfresco) and follow the installation advises.
If you'd like to have some examples on how to use chef-alfresco, please refer to the [Vagrant Alfresco](https://github.com/maoo/vagrant-alfresco) roles and Vagrantfiles for [allinone](https://github.com/maoo/vagrant-alfresco/blob/master/Vagrantfile.allinone) and [multivm](https://github.com/maoo/vagrant-alfresco/blob/master/Vagrantfile.multivm) installations

Configuration
========
Every recipe contains a set of default attribute values that can be easily overridden; there are also a default set of properties that is used across different recipes; below are reported the most common properties that you may be interested to override

### Default
* default['alfresco']['groupId'] - Default is "org.alfresco"
* default['alfresco']['version'] - Default is "4.2.e"
* default['alfresco']['default_port'] - The http port configured to run Tomcat; default is "8080"
* default['alfresco']['default_protocol'] - The protocol used to deploy Repository/Share apps
* default['alfresco']['root_dir'] - The 'alf_data' folder path; default is "/var/lib/tomcat7/alf_data"

Other attributes can be found in [attributes/default.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/default.rb)

### Build Tools
* default['xml']['packages'] - The list of OS packages needed by Nokogiri and other applications

Other attributes can be found in [attributes/build_tools.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/build_tools.rb)

Dependencies
========
* [swftools](https://github.com/fnichol/swftools)
* [openoffice](https://github.com/rgauss/chef-openoffice)
* [imagemagick](https://github.com/cookbooks/imagemagick)
* [database](https://github.com/opscode-cookbooks/database)
* [java](https://github.com/opscode-cookbooks/java)
* [mysql](https://github.com/opscode-cookbooks/mysql)
* [tomcat](https://github.com/opscode-cookbooks/tomcat)
* [openssl](https://github.com/opscode-cookbooks/openssl)
* [maven](https://github.com/opscode-cookbooks/maven)
* [xml](https://github.com/opscode-cookbooks/xml)
* [apt](https://github.com/opscode-cookbooks/apt)
* [build-essential](https://github.com/opscode-cookbooks/build-essential)

Credits
========
This project is a fork of the original [chef-alfresco](https://github.com/fnichol/chef-alfresco) developed by [Fletcher Nichol](https://github.com/fnichol); the code have been almost entirely rewritten, however the original implementation still works with Community 4.0.x versions and provides a different approach to Alfresco installation (using Alfresco Linux installer) and - most importantly - the set of recipes to rely upon in order to avoid reinventing the wheel.

A big thanks to Nichol to starting this effort!

License and Author
========
Copyright 2013, Maurizio Pillitu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.