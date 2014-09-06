# Artifact Deployer attributes
default['artifacts']['share']['groupId']      = node['alfresco']['groupId']
default['artifacts']['share']['artifactId']   = "share"
default['artifacts']['share']['version']      = node['alfresco']['version']
default['artifacts']['share']['type']         = "war"
default['artifacts']['share']['destination']  = node['tomcat']['webapp_dir']
default['artifacts']['share']['owner']        = node['tomcat']['user']
default['artifacts']['share']['unzip']        = false

#solrcore.properties placeholders
default['alfresco']['shareproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
default['alfresco']['shareproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
default['alfresco']['shareproperties']['alfresco.context']         = node['alfresco']['properties']['alfresco.context']
default['alfresco']['shareproperties']['alfresco.protocol']        = node['alfresco']['properties']['alfresco.protocol']
