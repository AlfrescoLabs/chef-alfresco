# Java defaults
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['java_home'] = '/usr/lib/jvm/java'
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '20dddd28ced3179685a5f58d3fcbecd8'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Java CA Certstore
default['alfresco']['certstore']['path'] = "#{node['java']['java_home']}/jre/lib/security/cacerts"
default['alfresco']['certstore']['pass'] = 'changeit'
