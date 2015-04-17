# Artifact Deployer attributes
node.default['artifacts']['share']['groupId']      = node['alfresco']['groupId']
node.default['artifacts']['share']['artifactId']   = "share"
node.default['artifacts']['share']['version']      = node['alfresco']['version']
node.default['artifacts']['share']['type']         = "war"
node.default['artifacts']['share']['destination']  = node['tomcat']['webapp_dir']
node.default['artifacts']['share']['owner']        = node['tomcat']['user']
node.default['artifacts']['share']['unzip']        = false

#CSRF settings
node.default['alfresco']['shareproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['shareproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
node.default['alfresco']['shareproperties']['alfresco.context']         = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['shareproperties']['alfresco.protocol']        = node['alfresco']['properties']['alfresco.protocol']
node.default['alfresco']['shareproperties']['referer']                  = ".*"
node.default['alfresco']['shareproperties']['origin']                   = ".*"

#Share URLs
node.default['alfresco']['properties']['share.context']      = '/share'
node.default['alfresco']['properties']['share.host']         = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['share.port']         = node['alfresco']['default_port']
node.default['alfresco']['properties']['share.protocol']     = node['alfresco']['default_protocol']

# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
node.default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share1']['priority'] = 52
node.default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.out.*'
node.default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share2']['priority'] = 53
