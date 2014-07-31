Introduction
---
chef-alfresco is a collection of recipes that provide a modular way to install Alfresco using Chef; it uses [artifact-deployer](https://github.com/maoo/artifact-deployer) to fetch artifacts from remote Apache Maven repositories and defines default values (i.e. Maven artifact coordinates) for all artifacts (WARs, ZIPs, JARs) involved in the Alfresco deployment process; it also depends on other third-party recipes that install the DB (MySQL), Servlet Container (Tomcat7) and transformation tools (ImageMagick, LibreOffice, swftools)

There is no default recipe in chef-alfresco, because the Alfresco installation order (in Chef terms, ```run_list```) may depend on architectural requirements; here follows the complete list:
* 3rdparty - Contains the tools that provide transformation features to Alfresco Repository
* mysql_createdb - Creates an alfresco DB (on MySQL) and grants all permissions to the alfresco user
* mysql_server - Install MySQL5 and grants access to ```node['alfresco']['db']['repo_hosts']```
* repo_config - Patches alfresco-global.properties and configures the deployment of
  * MySQL Java Connector, to be stored into Tomcat lib folder
  * Alfresco Repository WAR
* share_config - Creates shared/classes/alfresco/web-extension folder tree and patches share-config-custom.xml, setting the correct URLs for remote endpoints; it also configures the deployment of Alfresco Share WAR
* solr_config - Patches solrcore.properties and solr.xml files, configures the deployment of Apache Solr (Alfresco Patched version)
* apachelb - configures apache2 mod_balancer to dispach calls to given URLs

Usage
---
This is the minimum configuration that is needed in order to run Alfresco 4.2.f Community Edition
```
"tomcat" : {
    "base_version" : 7,
},
"alfresco" : {
    "allinone": true
}
```

This one is for Alfresco 4.2.2 Enterprise
```
"tomcat" : {
    "base_version" : 7,
},
"alfresco" : {
    "version" : "4.2.2"
}
```

The following one is an example of Alfresco 4.1.8 Enterprise using Apache as HTTP load balancer
```
"tomcat" : {
    "base_version" : 6,
},
"alfresco" : {
    "allinone": true
}
"java" : {
    "jdk_version" : "6",
}
"lb": {
    "balancers": {
        "alfresco": [{
            "ipaddress": "10.0.0.21",
            "route": "route21"
        },
        {
            "ipaddress": "10.0.0.22",
            "route": "route22"
        }],
        "share": [{
            "ipaddress": "10.0.0.31",
            "route": "route31"
        },
        {
            "ipaddress": "10.0.0.32",
            "route": "route32"
        }]
}
```

An example of ```run_list``` is

```
    "run_list": [
        "apt::default",
        "iptables::default",
        "alfresco::3rdparty",
        "alfresco::mysql_server",
        "alfresco::mysql_createdb",
        "alfresco::repo_config",
        "alfresco::share_config",
        "alfresco::solr_config",
        "tomcat::default",
        "tomcat::users",
        "artifact-deployer::default"
        "alfresco::apply_amps"
    ]
```

You can browse through the [attributes](https://github.com/maoo/chef-alfresco/tree/master/attributes) folder to check the default configuration values and how to override them.
The [templates](https://github.com/maoo/chef-alfresco/tree/master/templates) folder containes the Alfresco configuration files that will be patched with Chef attribute values.

Alfresco Global and Share Config
---
```alfresco-global.properties``` and ```share-config-custom.xml``` are *the* most frequent files in Alfresco to customise; chef-alfresco provides 3 ways to configure them

1. Define properties in the ```"alfresco"``` JSON element; these will be used to compile the file templates (check [templates/default](https://github.com/maoo/chef-alfresco/tree/master/templates/default))
2. Specify an ```"artifacts"/"classes"``` dependency pointing to a ZIP file that contains all ```shared/classes``` contents
3. Like #2, but with the possibility to ship - within the ZIP file - ```alfresco-global.properties.erb``` and ```share-config-custom.xml.erb```; if present, these files will be compiled as file templates (as in #1)

Projects Using chef-alfresco
---
* [alfresco-boxes](https://github.com/maoo/alfresco-boxes) is a collection of Vagrant/Packer definitions that runs/creates Virtualbox and AWS AMIs with different Alfresco stack architectures/platforms.

Dependencies
---
* [swftools](https://github.com/fnichol/swftools)
* [openoffice](https://github.com/rgauss/chef-openoffice)
* [imagemagick](https://github.com/cookbooks/imagemagick)
* [database](https://github.com/opscode-cookbooks/database)
* [java](https://github.com/opscode-cookbooks/java)
* [mysql](https://github.com/opscode-cookbooks/mysql)
* [tomcat](https://github.com/opscode-cookbooks/tomcat)
* [build-essential](https://github.com/opscode-cookbooks/build-essential)
* [artifact-deployer](https://github.com/maoo/artifact-deployer)

Credits
---
This project is a fork of the original [chef-alfresco](https://github.com/fnichol/chef-alfresco) developed by [Fletcher Nichol](https://github.com/fnichol); the code have been almost entirely rewritten, however the original implementation still works with Community 4.0.x versions and provides a different approach to Alfresco installation (using Alfresco Linux installer).

A big thanks to Nichol to starting this effort!

License and Author
---
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
