# Artifact Deployer attributes
default['artifacts']['share']['groupId']      = node['alfresco']['groupId']
default['artifacts']['share']['artifactId']   = "share"
default['artifacts']['share']['version']      = node['alfresco']['version']
default['artifacts']['share']['type']         = "war"
default['artifacts']['share']['destination']  = node['tomcat']['webapp_dir']
default['artifacts']['share']['owner']        = node['tomcat']['user']
default['artifacts']['share']['unzip']        = false