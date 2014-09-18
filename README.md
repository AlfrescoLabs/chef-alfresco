Introduction
---
chef-alfresco is a collection of recipes that provide a modular way to install Alfresco using Chef; it uses [artifact-deployer](https://github.com/maoo/artifact-deployer) to fetch artifacts from remote Apache Maven repositories and defines default values (i.e. Maven artifact coordinates) for all artifacts (WARs, ZIPs, JARs) involved in the Alfresco deployment process; it also depends on other third-party recipes that install - when needed - the DB (MySQL), Servlet Container (Tomcat7) and transformation tools (ImageMagick, LibreOffice, swftools)

Usage
---
Just include alfresco::default recipe in your `run_list` and then configure JSON attributes depending on what you want to achieve.

If no parameters are specified, all components will be installed (see below) with default attribute values.

Default Configurations
---

The following configurations apply across all components and are the most common to be overridden:
```
# Which chef-alfresco components to apply (see description below); iptables and lb are disabled by default
default['alfresco']['components'] = ['tomcat','transform','repo','share','solr','mysql']

# URL defaults to create share-repo-solr pointers across applications
default['alfresco']['default_hostname'] = "localhost"
default['alfresco']['default_port']     = "8080"
default['alfresco']['default_protocol'] = "http"

# Component-specific URL defaults
default['alfresco']['properties']['repo.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['share.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['solr.host'] = node['alfresco']['default_hostname']

# Maven artifact coordinates; change these to affect repo,share and solr artifact's configurations (see below)
default['alfresco']['groupId'] = "org.alfresco"
default['alfresco']['version'] = "5.0.a"

# The alfresco-global.properties dir.root, defaults to $TOMCAT_BASE/alf_data
# default['alfresco']['properties'] maps to alfresco-global.properties, you can add any other property
default['alfresco']['properties']['dir.root'] = "#{node['tomcat']['base']}/alf_data"

# Choose whether to start services or not after provisioning (Docker would fail if any service attempts to start)
default["alfresco"]["start_service"] = false

```
You can browse through the [attributes](https://github.com/maoo/chef-alfresco/tree/master/attributes) folder to check all configurations and their default values.

Components
---
For each component, chef-alfresco may include external Chef cookbooks and/or change some attribute's defaults; the logic is implemented in the Chef-Alfresco [default recipe](https://github.com/maoo/chef-alfresco/blob/master/recipes/default.rb)

#### tomcat

Installs and configures Apache Tomcat; more in details, this is the list of Apache Tomcat configuration items
- Standard Apache Tomcat installation using apt-get or yum repositories
- 6 (default) and 7 main versions supported
- Configurable SSL keystore/truststore in `server.xml`
- `$TOMCAT_HOME/conf/tomcat-users.xml` is configured properly to enable SSL communication between repo and solr

Hereby the default configuration that you can override in your configuration.
```
"tomcat" : {
  "files_cookbook" : "alfresco",
  "deploy_manager_apps": false,
  "jvm_memory" : "-Xmx1500M -XX:MaxPermSize=256M",
  "java_options" : "-Xmx1500M -XX:MaxPermSize=256M -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true"
}
```
The `files_cookbook` configuration allows to load file configuration's templates (such as [server.xml.erb](https://github.com/maoo/chef-alfresco/blob/master/templates/default/server.xml.erb)) from the alfresco Chef Cookbook instead of the original Tomcat one.

Check the [list of configuration attributes](https://github.com/maoo/chef-alfresco/blob/master/attributes/default.rb) and its defaults.

#### repo

Installs Alfresco Repository within a given Servlet container; the following features are provided

##### WAR installation

Fetch Alfresco WAR from a public/private Maven repository, URL or file-system (using [artifact-deployer](https://github.com/maoo/artifact-deployer)); by default, Chef Alfresco will fetch [Alfresco Repository 5.0.a WAR](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~org.alfresco~alfresco~5.0.a~war~), but you can override Maven coordinates to fetch your custom artifact (or define a url/path , check  [artifact-deployer docs](https://github.com/maoo/artifact-deployer)).

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
    "index.subsystem.name"  : "noindex"
  }
}
```

You can disable this feature (i.e. if you ship `alfresco-global.properties` within your war) by defining the following attribute:
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
You can disable this feature (i.e. if you ship a `log4j.properties` within your war) by defining the following attribute:
```
"alfresco": {
  "generate.repo.log4j.properties": false
}
```

##### JDBC Drivers

Downloads JDBC driver into Tomcat shared classloader, depending on Alfresco property `db.driver`:
  - if db.driver == 'org.gjt.mm.mysql.Driver', mysqlconnector is used
  - if db.driver == 'org.postgresql.Driver', postgresql is used
  - otherwise JDBC driver must be fetched configuring artifact-deployer

- `$TOMCAT_HOME/shared/classes` and `$TOMCAT_HOME/shared/*.jar` are configured as shared classloader

The [templates](https://github.com/maoo/chef-alfresco/tree/master/templates/default) folder contains the Alfresco configuration files that will be patched with Chef attribute values.
Check the [list of configuration attributes](https://github.com/maoo/chef-alfresco/blob/master/attributes/repo_config.rb) and its defaults.

#### share

Installs Alfresco Share application within a given Servlet container; the following features are provided:

##### share-config-custom.xml filtering

Generates (by default) `shared/classes/alfresco/web-extension/share-config-custom.xml` from a standard template, configuring CSRF origin/referer and endpoints pointing to Alfresco Repository:
```
"alfresco": {
  "shareproperties": {
    "alfresco.host"         : "my.repo.host.com",
    "alfresco.port"         : "80"
    ...
  }
}
```
You can optionally patch an existing share-config-custom.xml replacing all `@@key@@` (term delimiters are [configurable](https://github.com/maoo/artifact-deployer/blob/master/attributes/default.rb)) occurrences with attribute values of `node['alfresco']['shareproperties']` values; to enable this feature you must define the following parameter:
```
"alfresco": {
  "patch.share.config.custom" : true,
  "generate.share.config.custom" : true
  }
}
```

##### share-log4j.properties generation

Generates share-log4j.properties depending on properties defined in `node['alfresco']['share-log4j']`
```
"alfresco": {
  "generate.share.log4j.properties": false
}
```

Check the [list of configuration attributes](https://github.com/maoo/chef-alfresco/blob/master/attributes/share_config.rb) and its defaults.

#### solr

Installs Alfresco Solr application within a given Servlet container; the following features are provided:

##### solrcore.properties generation

Generate `alf_data/solr/workspace-SpacesStore/conf/solrcore.properties` and `alf_data/solr/archive-SpacesStore/conf/solrcore.properties` depending on properties defined in node['alfresco']['solrproperties']:

```
"alfresco": {
  "solrproperties": {
    "alfresco.host"         : "my.repo.host.com",
    "alfresco.port"         : "80"
    ...
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

There are no JSON configurations that affect this component.

#### mysql

Installs MySQL 5 Server, creates a database and a granted user; hereby the default configuration:

```
"alfresco" : {
  "db" : {
    "repo_hosts" : "%",
    "root_user": "root",
    "server_root_password" : "ilikerandompasswords"
  }
  "properties" : {
    "db.dbname" : "alfresco",
    "db.host": "localhost",
    "db.port" : "3306"
    "db.username" : "alfresco"
    "db.password" : "alfresco"
  }
}
```

#### iptables

Installs `iptables` and loads a given configuration, opening all ports needed by Alfresco to work properly:
- 50500 and 50508 for JMX
- 8009, 8080 and 8443 for Apache Tomcat
- 2121 for FTP server
- 7070 for VTI server
- 5701 for Clustering (Hazelcast)

To know more, check [alfresco-ports.erb](https://github.com/maoo/chef-alfresco/blob/master/templates/default/alfresco-ports.erb) template; there are no JSON configurations that affect this component.

#### lb (experimental)

The lb component - or load-balancing - installs Apache2 on port 80 and redirects connections to Tomcat (on port 8080); it only works on port 80, SSL have not been tested; hereby the default configuration:

```
"lb" : {
  "balancers" : {
    "alfresco" : [
      {
        "ipaddress" : "localhost",
        "port": "8080",
        "protocol" : "http"
      }
    ],
    "share" : [
      {
        "ipaddress" : "localhost",
        "port": "8080",
        "protocol" : "http"
      }
    ],
    "solr" : [
      {
        "ipaddress" : "localhost",
        "port": "8080",
        "protocol" : "http"
      }
    ]
  }
}
```
To know more, check [httpd-proxy-balancer.conf.erb](https://github.com/maoo/chef-alfresco/blob/master/templates/default/httpd-proxy-balancer.conf.erb) template and [attributes/apachelb.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/apachelb.rb)

Dependencies
---
Hereby the list of Chef cookbooks that are used together with chef-alfresco:
* [swftools](https://github.com/dhartford/chef-swftools)
* [openoffice](https://github.com/dhartford/chef-openoffice)
* [imagemagick](https://github.com/someara/imagemagick)
* [database](https://github.com/opscode-cookbooks/database)
* [java](https://github.com/opscode-cookbooks/java)
* [mysql](https://github.com/opscode-cookbooks/mysql)
* [tomcat](https://github.com/maoo/tomcat)
* [build-essential](https://github.com/opscode-cookbooks/build-essential)
* [artifact-deployer](https://github.com/maoo/artifact-deployer)

Credits
---
This project is a fork of the original [chef-alfresco](https://github.com/fnichol/chef-alfresco) developed by [Fletcher Nichol](https://github.com/fnichol); the code have been almost entirely rewritten, however the original implementation still works with Community 4.0.x versions and provides a different approach to Alfresco installation (using Alfresco Linux installer).

A big thanks to Nichol to starting this effort!

License and Author
---
Copyright 2014, Maurizio Pillitu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
