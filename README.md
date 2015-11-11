chef-alfresco
---
<div style="float: left">
    <img src="chef-alfresco-logo.png" alt="Chef Alfresco Logo" title="Chef Alfresco Logo"/>
</div>


[![Build Status](https://travis-ci.org/Alfresco/chef-alfresco.svg)](https://travis-ci.org/Alfresco/chef-alfresco)

chef-alfresco is a Chef cookbook that provides a modular, configurable and extensible way to install an Alfresco node/stack; `alfresco::default` parses `node['alfresco']['components']` and includes other `alfresco::*` recipes accordingly.

It is tested on Centos 6.5 and 7, though it should work also on Ubuntu 12 and 14 (feel free to open issues)

To know more about attribute definition and overriding, check [CHEF-ATTRIBUTES.md](CHEF-ATTRIBUTES.md)
To get a list of packaged installed, their sources and versions, check [PACKAGES.md](PACKAGES.md)

Local test (run)
---

#### Prerequisites
- [ChefDK](https://downloads.chef.io/chef-dk/)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Virtualbox](https://www.virtualbox.org/wiki/downloads)
- Make sure that `PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:/opt/chefdk/embedded/bin:$PATH`
- Make sure that you have [SSH Keys configured in GitHub](https://help.github.com/articles/generating-ssh-keys/)

#### Command
```
kitchen converge community
```
It takes roughly 20 minutes for a full default configuration (with a fast laptop/connection)

#### Access
The only fully functional HTTP endpoint is by default [http://localhost:8800](https://localhost:8800)

You can also access internal ports for debugging purposes (though you need to open them manually using Virtualbox, or uncommenting some entries in [Vagrantfile.erb](Vagrantfile.erb))
- [http://localhost:9000](http://localhost:9000) (haproxy)
- [http://localhost:8070/alfresco](http://localhost:8070/alfresco) (tomcat-alfresco)
- [http://localhost:8081/share](http://localhost:8081/share) (tomcat-share)
- [http://localhost:8090/solr](http://localhost:8090/solr) (tomcat-solr)

If you use analytics and/or media-management you can also access:
- (WIP) [http://localhost:8080/pentaho](http://localhost:8080/pentaho) (ba-server tomcat)
- [http://localhost:61616](http://localhost:61616) (activemq)

Access to the admin console is via (https://localhost:8843/alfresco/)[https://localhost:8843/alfresco/] and then Alfresco Administration Console.

#### Tweaking
Please [review CPU/memory configurations](Vagrantfile.erb) of chef-alfresco and adapt them to your workstation specs; hereby the default values:
```
c.vm.provider "virtualbox" do |v|
  v.memory = 4096
  v.cpus = 2
end
```

#### Guest Addition error

If you have issues installing the VM Guest Additions, run the following command

```
sudo ln -s /usr/include/ /lib/modules/3.10.0-123.el7.x86_64/build/
```

#### Waiting for `kitchen converge
1. First time you run it will take roughly 40 minutes
2. Second (or next) time you run a `kitchen converge` (without a previous `kitchen destroy`), it will take roughly 4 minutes

#### Caching (WIP)

It's possible to setup a local cached proxy, so that artifacts will be only downloaded once, in case of multiple runs; [here's how I've set it up on OSX](https://gist.github.com/maoo/3262589c9db989c6e948)

Chef Usage
---

Add `alfresco::default` in your `run_list`.

You can optionally shop through the [recipe list](https://github.com/maoo/chef-alfresco/blob/master/recipes) and customise your run, though it is advised (some ordering must be respected and may not be trivial) to use `alfresco::default` and define `node['alfresco']['components']` as explained below.

The following cookbooks are not part of Chef Supermarket; as such, you will need to explicitely define them as dependency of your Chef cookbook to make chef-alfresco working:

```
cookbook 'tomcat', git:'git@github.com:maoo/tomcat.git', tag: "v0.17.3-fork2"
cookbook 'maven', git:'git@github.com:maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'git@github.com:jenssegers/chef-file.git', tag: "v1.0.0"
```

Check [Berksfile](https://github.com/maoo/chef-alfresco/blob/master/Berksfile) for more info; you can also use Librarian to resolve transitive dependencies.

Packer Usage
---

You can use chef-alfresco in combination with [Packer Common](https://github.com/Alfresco/packer-common) or [Alfresco Boxes](https://github.com/maoo/alfresco-boxes) projects, to build AMIs, OVFs, Vagrant boxes, [Docker images](registry.hub.docker.com/u/maoo) and more.

Default Configurations
---

The most important configurations of chef-alfresco can be found in [attributes/default.rb](https://github.com/maoo/chef-alfresco/blob/master/attributes/default.rb); hereby the most important ones, as they define the components to use and the deployment features to enable:

```
# Alfresco components that are not enabled by default:
# analytics - Alfresco Reporting and Analytics feature; enterprise-only
# aos - Alfresco Office Services (WARs); enterprise-only
# media - Alfresco media-management; enterprise-only
# rsyslog - Remote logging
# logstash-forwarder - Remote logging
#
# Default Alfresco components
#
default['alfresco']['components'] = ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','rm','googledocs']

# Generates alfresco-global.properties using node['alfresco']['properties'] key/value attributes
default['alfresco']['generate.global.properties'] = true

# Generates share-config-custom.xml using a pre-defined template (check templates/default)
# to configure http endpoints and CSRF origin/referer
default['alfresco']['generate.share.config.custom'] = true

# Generates repo-log4j.properties using all node['alfresco']['repo-log4j']
# key/value attributes
default['alfresco']['generate.repo.log4j.properties'] = true

# Alfresco version; you can use Enterprise versions, ie. '5.0.2' and edition (to "enterprise")
default['alfresco']['version'] = "5.1-b-EA"
default['alfresco']['edition'] = "community"
# default['alfresco']['version'] = "5.0.2"
# default['alfresco']['edition'] = "enterprise"
```

Using Alfresco Enterprise
---
In order to configure access to Alfresco private repository, you need to use your customer credentials (same login as https://artifacts.alfresco.com); just set the following variables and kitchen command:
```
export NEXUS_USERNAME=myuser
export NEXUS_PASSWORD=mypwd
kitchen converge enterprise
```

Alternatively, you can use databags, check [other.json.example](test/integration/data_bags/maven_repos/other.json.example)

Using custom Maven repository
---
You can configure your own Maven repository:
- Create `test/integration/data_bags/maven_repos/mymvnrepo.json`:
```
{
  "id":"mymvnrepo",
  "url": "http://mymvnrepo.com/nexus/content/groups/public",
  "username":"myuser",
  "password":"mypwd"
}
```

Components
---
For each component, chef-alfresco may include external Chef cookbooks and/or change some attribute's defaults; the logic is implemented in the Chef-Alfresco [default recipe](https://github.com/maoo/chef-alfresco/blob/master/recipes/default.rb)

#### tomcat

Installs and configures Apache Tomcat using a [fork of Tomcat community cookbook](https://github.com/maoo/tomcat):
- Supports single multi-homed installations (default), allowing Alfresco Repository, Share and Solr to run on 3 (or 2) different Java virtual machines
- Supports versions 6 and 7 (default), depending on Alfresco version
- Standard Apache Tomcat installation using apt-get or yum repositories
- Configurable SSL keystore/truststore in `server.xml`

The complete list of configurable attributes can be found in [tomcat attributes](https://github.com/maoo/chef-alfresco/blob/master/recipe/_tomcat-attributes.rb); java configuration is included in the [default attribute file](https://github.com/maoo/chef-alfresco/blob/master/attributes/default.rb)

#### mysql

Installs and configures a local instance MySQL 5.6 Community Server, creates a database and a granted user; hereby the default configuration:

```
"alfresco" : {
  "db" : {
    "repo_hosts" : "%",
    "root_user": "root",
    "server_root_password" : "ilikerandompasswords"
  },
  "properties" : {
    "db.prefix": "mysql",
    "db.dbname" : "alfresco",
    "db.host": "localhost",
    "db.port" : "3306",
    "db.username" : "alfresco",
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

Resolve (and apply) Alfresco AMP files (as above, using artifact-deployer)
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

Generates alfresco-global.properties depending on attribute values:
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

Generates repo-log4j.properties depending on attribute values:
```
"alfresco": {
  "repo-log4j": {
    "log4j.rootLogger"                                : "error, File",
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
You can optionally patch an existing share-config-custom.xml replacing all `@@key@@` (term delimiters are [configurable](https://github.com/maoo/artifact-deployer/blob/master/attributes/default.rb)) occurrences with attribute values of `node['alfresco']['shareproperties']` values; to enable this feature you must define the following attributes:
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

Generate `solr/workspace-SpacesStore/conf/solrcore.properties` and `solr/archive-SpacesStore/conf/solrcore.properties` depending on attribute values:

```
"alfresco": {
  "solrproperties": {
    "alfresco.host"         : "my.repo.host.com",
    "alfresco.port"         : "80"
  }
}
```

##### log4j-solr.properties generation

Generates log4j-solr.properties depending on attributes defined in `node['alfresco']['solr-log4j']`

#### transform

Uses `alfresco::transformations` Chef recipe to install the following packages:
- openoffice
- imagemagick
- swftools

#### media

Installs and configures Alfresco media-management; since the feature is currently only available via Alfresco Customer Success website, you must download it first to a known Maven Repo or HTTP location and override the following attributes:

```
"alfresco" : {
  "components" : ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','rm','googledocs','media']
}
"media" : {
  # "url" : "<url_to_media_zip_distro>",
  "groupId" : "my_media_group_id",
  "artifactId" : "my_media_distribution",
  "version" : "0.0.1",
  "type" : "zip"
}
```

#### analytics

Installs and configures Alfresco analytics; as per media, you must download the zip distribution package and serve it via HTTP or Maven repo; attribute values are shown below:

```
attributes: {
  "alfresco" : {
    "components" : ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','rm','googledocs','analytics'],
  "artifacts" : {
    "analytics" : {
      "url" : "<url_to_analytics_alfresco_zip_distro>"
    },
    "alfresco-pentaho" : {
      "url" : "<url_to_alfresco_pentaho_zip_distro>"
    }
  }
}
```

#### rm

Installs Alfresco Records Management, using [Alfresco RM 2.3 AMP](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~~alfresco-rm~2.3~~),

#### googledocs

Installs Alfresco Googledocs, using [Alfresco Googledocs 3.0.2 repo and share AMPs](https://artifacts.alfresco.com/nexus/index.html#nexus-search;gav~org.alfresco.integrations~alfresco-googledocs-*~3.0.2~~),

#### haproxy

HAproxy is installed as OS package (using [haproxy community cookbook](https://github.com/hw-cookbooks/haproxy)) and configured using attributes defined in [haproxy.rb attribute file](https://github.com/maoo/chef-alfresco/blob/master/recipes/_haproxy-attributes.rb)

This component will also install Rsyslog server, used to dump haproxy logs into /var/log/haproxy/haproxy/log

#### nginx

Nginx is installed as OS package (using [nginx community cookbook](https://github.com/miketheman/nginx)) and configured using attributes defined in [nginx.rb attribute file](https://github.com/maoo/chef-alfresco/blob/master/recipes/_nginx-attributes.rb)

#### rsyslog

Configures and runs an rsyslog standalone installation, which logs locally by default; you can set `node['rsyslog']['server_ip']` to configure the remote server to send logs to; for more info check the [rsyslog community cookbook](https://github.com/opscode-cookbooks/rsyslog)

#### logstash-forwarder

Configures and runs an logstash-forwarder to ship logs to a remote logstash server; you can set `node['logstash-forwarder']['logstash_servers']` to configure the remote server to send logs to; for more info check the [logstash community cookbook](https://github.com/elastic/logstash-forwarder)

Roadmap
---
- analytics integration (MUST)
- media management & analytics integration with rsyslog (MUST)
- [BATS](https://github.com/sstephenson/bats) testing (MUST)
- postgresql integration (SHOULD)
- Ubuntu compatibility (COULD)
- Windows compatibility (WOULD)

Unit testing
---
Unit testing coverage is still low; we use foodcritic and knife tests.
```
bundle update
bundle exec rake
```

We plan to use [BATS](https://github.com/sstephenson/bats)

Integration testing
---
chef-alfresco is on [Travic CI](https://travis-ci.org/maoo/chef-alfresco)

Integration testing coverage is still low; we kitchen and serverspec.
```
kitchen test
```

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
