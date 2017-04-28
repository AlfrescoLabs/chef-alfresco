# Java defaults
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['java_home'] = '/usr/lib/jvm/java'
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '75b2cb2249710d822a60f83e28860053'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Java CA Certstore
default['alfresco']['certstore']['path'] = "#{node['java']['java_home']}/jre/lib/security/cacerts"
default['alfresco']['certstore']['pass'] = 'changeit'
