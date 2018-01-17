# Java defaults
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['java_home'] = '/usr/lib/jvm/java'
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '781e3779f0c134fb548bde8b8e715e90'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Java CA Certstore
default['alfresco']['certstore']['path'] = "#{node['java']['java_home']}/jre/lib/security/cacerts"
default['alfresco']['certstore']['pass'] = 'changeit'
