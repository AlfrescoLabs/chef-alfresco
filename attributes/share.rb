# Haproxy configuration
default['haproxy']['backends']['share']['acls']= ['path_beg /share', 'path_reg ^$|^/$']
default['haproxy']['backends']['share']['entries'] = ["option httpchk GET /share","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['share']['nodes']['localhost'] = "127.0.0.1"
default['haproxy']['backends']['share']['port'] = 8081

# Where are redirects belonging to?
default['haproxy']['redirects'] = ["redirect location /share/ if !is_share !is_alfresco !is_solr4 !is_aos_root !is_aos_vti"]

# Artifact Deployer attributes
default['artifacts']['share']['groupId'] = node['alfresco']['groupId']
default['artifacts']['share']['artifactId'] = "share"
default['artifacts']['share']['version'] = node['alfresco']['version']
default['artifacts']['share']['type'] = "war"
default['artifacts']['share']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['share']['owner'] = node['alfresco']['user']
default['artifacts']['share']['unzip'] = false

# Share CSRF settings
default['alfresco']['shareproperties']['alfresco.host'] = node['alfresco']['properties']['alfresco.host']
default['alfresco']['shareproperties']['alfresco.port'] = node['alfresco']['properties']['alfresco.port']
default['alfresco']['shareproperties']['alfresco.context'] = node['alfresco']['properties']['alfresco.context']
default['alfresco']['shareproperties']['alfresco.protocol'] = node['alfresco']['properties']['alfresco.protocol']
default['alfresco']['shareproperties']['referer'] = ".*"
default['alfresco']['shareproperties']['origin'] = ".*"
