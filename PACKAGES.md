Packages and versions
---

Hereby the list of packages, cookbooks, YUM (or source/binary) repositories and versions installed by chef-alfresco (depending on components being enabled) - (28/06/2015)

| Package Name | Chef Cookbook | Repository | Version | Version in Code |
| ------------ |:-------------:| ----------:| -------:| ---------------:|
| Nginx | [nginx](https://github.com/miketheman/nginx) | [centosnginx](http://nginx.org/packages/centosnginx) | latest (1.8.0) | no versions specified in code |
| Oracle JDK | [java](https://github.com/agileorbit-cookbooks/java) | | 8u45-b14 | [default.rb](https://github.com/Alfresco/chef-alfresco/blob/master/attributes/default.rb) |
| Apache Tomcat | [maoo/tomcat](https://github.com/maoo/tomcat) | [centos](http://mirrorlist.centos.org) | latest (7.0.54-2.el7_1) | no versions specified in code |
| Tomcat Catalina JMX | | | | |
| Tomcat native | [tomcat.rb]() | epel | latest (1.1.30-1.el7) | no versions specified in code |
| Tomcat APR | | | latest(1.4.8-3.el7) | no versions specified in code |
| ABRT (shouldn't be here) | | | | |
| HAproxy (needs update!) | [haproxy](https://github.com/hw-cookbooks/haproxy) |  [centos](http://mirrorlist.centos.org) | latest(1.5.4-el7_1) | no versions specified in code |
| MySQL Community | [mysql](https://github.com/chef-cookbooks/mysql) | [mysql-5.6-community](http://repo.mysql.com/yum/mysql-5.6-community) | 5.6.25-2.el7 | |
| ImageMagick | | [centos](http://mirrorlist.centos.org) | 6.7.8.9-10.el7 | |
| Media Libraries[1] | [transformations.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) | [atrpms](http://dl.atrpms.net) | check repo | no versions specified in code |
| LibreOffice | [libreoffice-cookbook](https://github.com/Youscribe/libreoffice-cookbook) | [centos](http://mirrorlist.centos.org) | 4.2.6.3-5.el7 | |
| SWF Tools | [transformations.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) | [www.swftools.org](http://www.swftools.org/swftools-2013-04-09-1007) | 2013-04-09-1007 | [transformations.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/transformations.rb) |
| JDBC MySQL Driver | [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |  [maven.org](http://search.maven.org/#artifactdetails%7Cmysql%7Cmysql-connector-java%7C5.1.30%7Cjar) | 5.1.30 |  [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |
| JDBC PostgreSQL Driver | [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |  [maven.org](http://search.maven.org/#artifactdetails%7Corg.postgresql%7Cpostgresql%7C9.2-1004-jdbc4%7Cjar)  | 9.2.1004-jdbc4 | [_repo-attributes.rb](https://github.com/Alfresco/chef-alfresco/blob/master/recipes/_repo-attributes.rb) |
| PostgreSQL | | | | |
| AWS Commandline | | | | |

> [1] Media libraries - libogg libvorbis vorbis-tools libmp3lame0 libfaac0 faac faac-devel faad2 libfaad2 faad2-devel libtheora-devel libvorbis-devel libvpx-devel xvidcore xvidcore-devel x264 x264-devel ffmpeg ffmpeg-devel
