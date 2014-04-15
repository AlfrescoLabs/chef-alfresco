Introduction
---
chef-alfresco is a collection of recipes that provide a modular way to install Alfresco using Chef; it uses [artifact-deployer](https://github.com/maoo/artifact-deployer) to fetch artifacts from remote Apache Maven repositories, given artifact coordinates in a JSON format, along with other third-party recipes that install the DB (MySQL), Servlet Container (Tomcat7) and transformation tools (ImageMagick, LibreOffice, swftools)

There is no default recipe in chef-alfresco, because the Alfresco installation order (in Chef terms, ```run_list```) may depend on architectural requirements; here follows the complete list:
* 3rdparty - Contains the tools that provide transformation features to Alfresco Repository
* mysql_createdb - Creates an alfresco DB (on MySQL) and grants all permissions to the alfresco user
* mysql_server - Install MySQL5 and grants access to ```node['alfresco']['db']['repo_hosts']```
* repo_config - Patches alfresco-global.properties and configures the deployment of
  * MySQL Java Connector, to be stored into Tomcat lib folder
  * Alfresco Repository WAR
* share_config - Creates shared/classes/alfresco/web-extension folder tree and patches share-config-custom.xml, setting the correct URLs for remote endpoints; it also configures the deployment of Alfresco Share WAR
* solr_config - Patches solrcore.properties and solr.xml files, configures the deployment of Apache Solr (Alfresco Patched version)
* tomcat - Installs (a 'rewinded') Apache Tomcat (that won't start after the installation; it will be restarted on each repo/share/solr redeployment)

Usage
---
```
"tomcat" : {
    "base_version" : 7,
    "user" : "tomcat7",
    "group" : "tomcat7",
    "java_options" : "-Xmx1500M -XX:MaxPermSize=256M -Dsolr.solr.home=/var/lib/tomcat7/alf_data/solrhome"
},
"alfresco" : {
    "maven" : {
        "repo_type" : "public"
    },
    "solr" : {
        "alfresco_secureComms" : "none",
        "solr_secureComms" : "none"
    }
},
"maven" : {
    "repos" : {
        "maoo-public-cloudbees" : {
            "url" : "https://repository-maoo.forge.cloudbees.com/release"
        }
    }
},
"artifacts" : {
    "alfresco" : {
        "enabled" : true,
        "groupId" : "it.session.alfresco",
        "artifactId" : "alfresco-nossl",
        "version" : "4.2.f"
    },
    "solr" : {
        "enabled" : true,
        "groupId" : "it.session.alfresco",
        "artifactId" : "apache-solr-nossl",
        "version" : "1.4.1-alfresco-patched"
    }
},
"java" : {
    "default" : true,
    "jdk_version" : "7",
    "install_flavor" : "oracle",
    "oracle" : {
        "accept_oracle_download_terms" : true
    }
}
```

An example of ```run_list``` is

```
    "run_list": [
        "apt::default",
        "alfresco::3rdparty",
        "alfresco::mysql_server",
        "alfresco::mysql_createdb",
        "tomcat::default",
        "alfresco::repo_config",
        "alfresco::share_config",
        "artifact-deployer::default",
        "alfresco::solr_config"]
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