chef-alfresco
---

[![Build Status](https://travis-ci.org/maoo/chef-alfresco.svg)](https://travis-ci.org/maoo/chef-alfresco)

chef-alfresco is a Chef cookbook that provides a modular, configurable and extensible way to install an Alfresco node/stack; `alfresco::default` parses `node['alfresco']['components']` and includes other `alfresco::*` recipes accordingly.

It is tested on Centos 6.5 and 7, though it should work also on Ubuntu 12 and 14.

Usage
---

Add `alfresco::default` in your `run_list`.

You can optionally shop through the [recipe list](https://github.com/maoo/chef-alfresco/blob/master/recipes) and customise your run, though it is advised (some ordering must be respected and may not be trivial) to use `alfresco::default` and define `node['alfresco']['components']` as explained below.

Testing
---
You can use `kitchen converge` to test Alfresco locally (Kitchen is now shipped with the [ChefDK](https://downloads.chef.io/chef-dk/)); when the command completes, you can access Share UI on http://localhost:8800/share (mapped to guest VM port 80)

Alternatively, you can access:
- http://localhost:8070/alfresco
- http://localhost:8080/share
- http://localhost:8090/solr

Default Configurations
---

The most important configurations of chef-alfresco can be found in [attributes/default.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/default.rb); hereby the most important ones, as they define the components to use and the deployment features to enable:

```
# Which chef-alfresco components to apply (see description below)
# Also 'aos' (enterprise-only) and 'spp' are available
default['alfresco']['components'] = ['haproxy', 'nginx','tomcat','transform','repo','share','solr','mysql',rm','googledocs']

# Generates alfresco-global.properties using node['alfresco']['properties'] key/value attributes
default['alfresco']['generate.global.properties'] = true

# Generates share-config-custom.xml using a pre-defined template (check templates/default)
# to configure http endpoints and CSRF origin/referer
default['alfresco']['generate.share.config.custom'] = true

# Generates repo-log4j.properties using all node['alfresco']['repo-log4j']
# key/value attributes
default['alfresco']['generate.repo.log4j.properties'] = true

# Alfresco version; you can use Enterprise versions, ie. '5.0.1'
default['alfresco']['version'] = "5.0.d"
```

Using Alfresco Enterprise
---
As mentioned above, you can use an Enterprise version to override `node['alfresco']['version']` attribute; however, you still need to set your artifacts.alfresco.com credentials into [maven_repos/private](https://github.com/maoo/chef-alfresco/blob/master/test/integration/data_bags/maven_repos/private.json) databag item.

Components
---
For each component, chef-alfresco may include external Chef cookbooks and/or change some attribute's defaults; the logic is implemented in the Chef-Alfresco [default recipe](https://github.com/maoo/chef-alfresco/blob/master/recipes/default.rb)

#### tomcat

Installs and configures Apache Tomcat using a [fork of Tomcat community cookbook](https://github.com/maoo/tomcat):
- Supports single multi-homed installations, allowing Alfresco Repository, Share and Solr to run on 3 (or 2) different Java virtual machines
- Supports versions 6 and 7 (default), depending on Alfresco version
- Standard Apache Tomcat installation using apt-get or yum repositories
- Configurable SSL keystore/truststore in `server.xml`

Hereby the most important (default) configuration that you can override; the complete list can be found in [attributes/tomcat.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/tomcat.rb) and [recipes/_attributes.rb](https://github.com/maoo/chef-alfresco/blob/master/recipes/_attributes.rb)

```
"tomcat" : {
  "run_base_instance" : false,
  "additional_tomcat_packages" : ["tomcat-native", "apr", "abrt"],
  "files_cookbook" : "alfresco",
  "deploy_manager_apps": false,
  "jvm_memory" : "-Xmx1500M -XX:MaxPermSize=256M",
  "java_options" : "-Xmx1500M -XX:MaxPermSize=256M -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true"
}
```

#### mysql

Installs and configures a local instance MySQL 5.7 Community Server, creates a database and a granted user; hereby the default configuration:

```
"alfresco" : {
  "db" : {
    "repo_hosts" : "%",
    "root_user": "root",
    "server_root_password" : "ilikerandompasswords"
  }
  "properties" : {
    "db.prefix": "mysql",
    "db.dbname" : "alfresco",
    "db.host": "localhost",
    "db.port" : "3306"
    "db.username" : "alfresco"
    "db.password" : "alfresco"
  }
}
```

#### repo

Installs Alfresco Repository within a given Servlet container; the following features are provided.

##### WAR installation

Fetch Alfresco WAR from a public/private Maven repository, URL or file-system (using [artifact-deployer](https://github.com/maoo/artifact-deployer)); by default, Chef Alfresco will fetch [Alfresco Repository 5.0.d WAR](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~org.alfresco~alfresco~5.0.d~war~), but you can override Maven coordinates to fetch your custom artifact (or define a url/path , check  [artifact-deployer docs](https://github.com/maoo/artifact-deployer)); since the WAR already includes log4j.properties and alfresco-global.properties, we need to disable the file generation features

```
"artifacts": {
  "alfresco": {
    "groupId": "com.acme.alfresco",
    "artifactId": "alfresco-enterprise-foundation",
    "version": "1.0.2"
  }
}
```

##### AMP installation

Resolve (and apply) Alfresco AMP files (as above, using artifact-deployer); SPP extension is added by default
```
"artifacts": {
  "my-amp": {
      "enabled": true,
      "path": "/mypath/my-amp/target/my-amp.amp",
      "destination": "/var/lib/tomcat7/amps",
      "owner": "tomcat7"
  }
}
```

##### alfresco-global.properties generation

Generates alfresco-global.properties depending on properties defined in `node['alfresco']['properties']`
```
"alfresco": {
  "properties": {
    "db.host"               : "db.mysql.demo.acme.com",
    "dir.license.external"  : "/alflicense",
    "index.subsystem.name"  : "lucene"
  }
}
```

You can disable this feature (i.e. if you ship `alfresco-global.properties` within your WAR) by defining the following attribute:
```
"alfresco": {
  "generate.global.properties": false
}
```

##### repo-log4j.properties generation

Generates repo-log4j.properties depending on properties defined in `node['alfresco']['repo-log4j']`
```
"alfresco": {
  "repo-log4j": {
    "log4j.rootLogger"                                : "error, Console, File",
    "log4j.appender.Console"                          : "org.apache.log4j.ConsoleAppender",
    "log4j.appender.Console.layout"                   : "org.apache.log4j.PatternLayout",
    "log4j.appender.Console.layout.ConversionPattern" : "%d{ISO8601} %x %-5p [%c{3}] [%t] %m%n",
    "log4j.appender.File"                             : "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.File.Append"                      : "true",
    "log4j.appender.File.DatePattern"                 : "'.'yyyy-MM-dd",
    "log4j.appender.File.layout"                      : "org.apache.log4j.PatternLayout",
    "log4j.appender.File.layout.ConversionPattern"    : "%d{ABSOLUTE} %-5p [%c] %m%n"
  }
}
```
You can disable this feature (i.e. if you ship a `log4j.properties` within your WAR) by defining the following attribute:
```
"alfresco": {
  "generate.repo.log4j.properties": false
}
```

The [templates](https://github.com/maoo/chef-alfresco/tree/master/templates/default) folder contains the Alfresco configuration files that will be patched with Chef attribute values.
Check the [list of configuration attributes](https://github.com/maoo/chef-alfresco/blob/master/recipes/_attributes_repo.rb) and its defaults.

##### JDBC Drivers

The JDBC driver JAR is downloaded and placed into the Tomcat lib folder, depending on `node['alfresco']['properties']['db.prefix']` attribute; currently `mysql` and `psql` are supported.

#### share

Installs Alfresco Share application within a given Servlet container; the following features are provided:

##### share-config-custom.xml filtering

Generates (by default) `shared/classes/alfresco/web-extension/share-config-custom.xml` from a standard template, configuring CSRF origin/referer and endpoints pointing to Alfresco Repository:
```
"alfresco": {
  "shareproperties": {
    "alfresco.host"         : "my.repo.host.com",
    "alfresco.port"         : "80"
  }
}
```
You can optionally patch an existing share-config-custom.xml replacing all `@@key@@` (term delimiters are [configurable](https://github.com/maoo/artifact-deployer/blob/master/attributes/default.rb)) occurrences with attribute values of `node['alfresco']['shareproperties']` values; to enable this feature you must define the following parameter:
```
"alfresco": {
  "patch.share.config.custom" : false,
  "generate.share.config.custom" : true
  }
}
```

#### solr

Installs Alfresco Solr application within a given Servlet container; the following features are provided:

##### solrcore.properties generation

Generate `solr/workspace-SpacesStore/conf/solrcore.properties` and `solr/archive-SpacesStore/conf/solrcore.properties` depending on properties defined in node['alfresco']['solrproperties']:

```
"alfresco": {
  "solrproperties": {
    "alfresco.host"         : "my.repo.host.com",
    "alfresco.port"         : "80"
  }
}
```

##### log4j-solr.properties generation

Generates log4j-solr.properties depending on properties defined in `node['alfresco']['solr-log4j']`

#### transform

Uses `alfresco::3rdparty` Chef recipe to install the following packages:
- openoffice
- imagemagick
- swftools

#### spp

Installs Alfresco SharePoint Protocol, using [Alfresco Sharepoint Protocol 5.0.d AMP](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~~alfresco-spp~5.0.d~~),

#### rm

Installs Alfresco Records Management, using [Alfresco RM 2.3 AMP](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~~alfresco-rm~2.3~~),

#### googledocs

Installs Alfresco Googledocs, using [Alfresco Googledocs 3.0.2 repo and share AMPs](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~org.alfresco.integrations~alfresco-googledocs-*~3.0.2~~),

#### haproxy

HAproxy is installed as OS package (using [haproxy community cookbook](https://github.com/hw-cookbooks/haproxy)) and configured using attributes defined in [haproxy.rb attribute file](https://github.com/maoo/chef-alfresco/blob/master/attributes/haproxy.rb)

#### nginx

Nginx is installed as OS package (using [nginx community cookbook](https://github.com/miketheman/nginx)) and configured using attributes defined in [nginx.rb attribute file](https://github.com/maoo/chef-alfresco/blob/master/attributes/nginx.rb)

Dependencies
---
Chef-Alfresco delegates the installation of 3rd party software to external cookbooks; you can find a complete list in [metadata.rb](https://github.com/maoo/chef-alfresco/blob/master/metadata.rb)

Credits
---
This project is a fork of the original [chef-alfresco](https://github.com/fnichol/chef-alfresco) developed by [Fletcher Nichol](https://github.com/fnichol); the code have been almost entirely rewritten, however the original implementation still works with Community 4.0.x versions and provides a different approach to Alfresco installation (using Alfresco Linux installer).

A big thanks to Nichol for starting this effort!

License and Author
---
Copyright 2015, Alfresco

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
