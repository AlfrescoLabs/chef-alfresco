Packages and versions
---

Hereby the list of packages, cookbooks, YUM (or source/binary) repositories and versions installed by chef-alfresco (depending on components being enabled) - (28/06/2015)

| Package Name | Chef Cookbook | Repository | Version | Version in Code |
| ------------ |:-------------:| ----------:| -------:| ---------------:|
| Nginx | [nginx](https://github.com/miketheman/nginx) | [centosnginx](http://nginx.org/packages/centosnginx) | latest (1.8.0) | no versions specified in code |
| Oracle JDK | [java](https://github.com/agileorbit-cookbooks/java) | [oracle.com](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) | 8u45-b14 | [default.rb](https://github.com/Alfresco/chef-alfresco/blob/master/attributes/default.rb) |
| Apache Tomcat | [maoo/tomcat](https://github.com/maoo/tomcat) | [centos](http://mirrorlist.centos.org) | latest (7.0.54-2.el7_1) | no versions specified in code |
| Tomcat Catalina JMX | [chef-alfresco::_tomcat-attributes](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_tomcat-attributes.rb) |  [maven.org](http://search.maven.org/#artifactdetails%7Corg.apache.tomcat%7Ctomcat-catalina-jmx-remote%7C7.0.54%7Cjar) | 7.0.54 | [_tomcat-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_tomcat-attributes.rb) |
| Tomcat native | [chef-alfresco::tomcat](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/tomcat.rb) | [epel](https://mirrors.fedoraproject.org/metalink?repo=epel-7) | latest (1.1.30-1.el7) | no versions specified in code |
| Tomcat APR | [chef-alfresco::tomcat](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/tomcat.rb) | [centos](http://mirrorlist.centos.org) | latest (1.4.8-3.el7) | no versions specified in code |
| HAproxy (needs update!) | [haproxy](https://github.com/hw-cookbooks/haproxy) |  [centos](http://mirrorlist.centos.org) | latest (1.5.4-el7_1) | no versions specified in code |
| MySQL Community | [mysql](https://github.com/chef-cookbooks/mysql) | [mysql-5.6-community](http://repo.mysql.com/yum/mysql-5.6-community) | latest (5.6.25-2.el7) | no versions specified in code |
| ImageMagick | [imagemagick](https://github.com/someara/imagemagick) | [centos](http://mirrorlist.centos.org) | latest (6.7.8.9-10.el7) | no versions specified in code |
| Media Libraries[1] | [chef-alfresco::transformations](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) | [atrpms](http://dl.atrpms.net) | check repo | no versions specified in code |
| LibreOffice | [libreoffice-cookbook](https://github.com/Youscribe/libreoffice-cookbook) | [centos](http://mirrorlist.centos.org) | latest (4.2.6.3-5.el7) | no versions specified in code |
| SWF Tools | [transformations.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) | [www.swftools.org](http://www.swftools.org/swftools-2013-04-09-1007) | 2013-04-09-1007 | [chef-alfresco::transformations](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) |
| JDBC MySQL Driver | [chef-alfresco::_repo-attributes](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |  [maven.org](http://search.maven.org/#artifactdetails%7Cmysql%7Cmysql-connector-java%7C5.1.30%7Cjar) | 5.1.30 |  [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |
| JDBC PostgreSQL Driver | [chef-alfresco::_repo-attributes](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |  [maven.org](http://search.maven.org/#artifactdetails%7Corg.postgresql%7Cpostgresql%7C9.2-1004-jdbc4%7Cjar)  | 9.2.1004-jdbc4 | [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |
| PostgreSQL (WIP) | [postgresql](https://github.com/phlipper/chef-postgresql) | [centos](http://mirrorlist.centos.org) | 9.3 | postgresql-local-server.rb |
| Apache Maven | [maven](https://github.com/opscode-cookbooks/maven) | [Apache Mirrors](http://apache.mirrors.tds.net/) | 3.1.1 | [default.rb](https://github.com/opscode-cookbooks/maven/blob/master/attributes/default.rb#L31), overridable |
| AWS Commandline | [artifact-deployer::awscli](https://github.com/maoo/artifact-deployer/blob/master/recipes/awscli.rb) | [pypi](https://pypi.python.org/pypi) | latest (1.7.36) | no versions specified in code |
| ABRT (shouldn't be here) | [chef-alfresco::_tomcat-attributes](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_tomcat-attributes.rb) | [centos](http://mirrorlist.centos.org) | latest (2.1.11-22.el7.centos.0.1) | no versions specified in code |

> [1] Media libraries - libogg libvorbis vorbis-tools libmp3lame0 libfaac0 faac faac-devel faad2 libfaad2 faad2-devel libtheora-devel libvorbis-devel libvpx-devel xvidcore xvidcore-devel x264 x264-devel ffmpeg ffmpeg-devel
