# Java defaults
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['java_home'] = '/usr/lib/jvm/java'
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '2d59a3add1f213cd249a67684d4aeb83'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Java CA Certstore
default['alfresco']['certstore']['path'] = "#{node['java']['java_home']}/jre/lib/security/cacerts"
default['alfresco']['certstore']['pass'] = 'changeit'
