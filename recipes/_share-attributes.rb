# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
node.default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share1']['priority'] = 52
node.default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.out.*'
node.default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share2']['priority'] = 53

# Haproxy configuration
node.default['haproxy']['backends']['share']['acls']= ['path_beg /share', 'path_reg ^$|^/$']
node.default['haproxy']['backends']['share']['entries'] = ["option httpchk GET /share","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
node.default['haproxy']['backends']['share']['nodes']['localhost'] = "127.0.0.1"
node.default['haproxy']['backends']['share']['port'] = 8081

# Where are redirects belonging to?
node.default['haproxy']['redirects'] = ["redirect location /share/ if !is_share !is_alfresco !is_solr4 !is_aos_root !is_aos_vti"]

# Artifact Deployer attributes
node.default['artifacts']['share']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['share']['artifactId'] = "share"
node.default['artifacts']['share']['version'] = node['alfresco']['version']
node.default['artifacts']['share']['type'] = "war"
node.default['artifacts']['share']['destination'] = node['tomcat']['webapp_dir']
node.default['artifacts']['share']['owner'] = node['alfresco']['user']
node.default['artifacts']['share']['unzip'] = false

# Share CSRF settings
node.default['alfresco']['shareproperties']['alfresco.host'] = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['shareproperties']['alfresco.port'] = node['alfresco']['properties']['alfresco.port']
node.default['alfresco']['shareproperties']['alfresco.context'] = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['shareproperties']['alfresco.protocol'] = node['alfresco']['properties']['alfresco.protocol']
node.default['alfresco']['shareproperties']['referer'] = ".*"
node.default['alfresco']['shareproperties']['origin'] = ".*"
