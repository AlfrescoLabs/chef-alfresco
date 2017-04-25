# Java defaults
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['java_home'] = '/usr/lib/jvm/java'
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '91972fb4e753f1b6674c2b952d974320'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Java CA Certstore
default['alfresco']['certstore']['path'] = "#{node['java']['java_home']}/jre/lib/security/cacerts"
default['alfresco']['certstore']['pass'] = 'changeit'
