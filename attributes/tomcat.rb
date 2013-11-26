#
# Cookbook Name:: alfresco
# attributes:: default
#
# Author:: Fletcher Nichol (<fnichol@nichol.ca>)
#
# Copyright:: 2011, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
default['tomcat']['java_options'] = " -Xms128m -Xmx1024m -XX:MaxPermSize=400m -Djava.awt.headless=true"
#node.set['tomcat']['restart_timing'] = "immediately"

# default["tomcat"]["keystore_file"] = "keystore/ssl.keystore"
# default["tomcat"]["keystore_password"] = "kT9X6oe68t"
# default["tomcat"]["truststore_file"] = "keystore/ssl.truststore"
# default["tomcat"]["truststore_password"] = "kT9X6oe68t"
# 
# default["tomcat"]["ssl_cert_file"] = nil
# default["tomcat"]["ssl_key_file"] = nil
# 
# default["tomcat"]["keystore_file"] = "keystore"
# default["tomcat"]["keystore_type"] = "jceks"
# default["tomcat"]["truststore_type"] = "jceks"
# 
# default["tomcat"]["certificate_dn"] = "CN=Alfresco Repository, OU=Unknown, O=Alfresco Software Ltd., L=Maidenhead, ST=UK, C=GB"

# Implemented operations described at http://wiki.alfresco.com/wiki/Alfresco_And_SOLR#Security
default['tomcat']['ca_key'] = "ca.key"
default['tomcat']['repo_csr'] = "repo.csr"
default['tomcat']['ssl_keystore'] = "ssl.keystore"
default['tomcat']['ssl_truststore'] = "ssl.truststore"
default['tomcat']['ca_crt'] = "ca.crt"
default['tomcat']['ca_validity'] = 3650
default['tomcat']['ca_passphrase'] = "foobar"
default['tomcat']['dname'] = "CN=Alfresco CA, O=Alfresco Software Ltd.,L=Maidenhead,ST=UK,C=GB"
default['tomcat']['ca_subject'] = "/CN=Alfresco CA/O=Alfresco Software Ltd./L=Maidenhead/ST=UK/C=GB"
default['tomcat']['key_pass'] = "ciaociao"
default['tomcat']['store_pass'] = "passwd"

# Used for filling context.xml and JAVA_OPTS with right values
default["tomcat"]["keystore_file"] = node['tomcat']['ssl_keystore']
default["tomcat"]["keystore_type"] = "jceks"
default["tomcat"]["keystore_password"] = node['tomcat']['key_pass']
#default["tomcat"]["truststore_file"] = node['tomcat']['ssl_truststore']
#default["tomcat"]["truststore_password"] = node['tomcat']['store_pass']

default['tomcat']['keystore_properties'] = "keystore-passwords.properties"
default['tomcat']['ssl_keystore_properties'] = "ssl-keystore-passwords.properties"