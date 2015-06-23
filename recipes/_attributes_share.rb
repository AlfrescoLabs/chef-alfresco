# Haproxy configuration
node.default['haproxy']['backends']['share']['acls']['path_beg'] = ["/share"]
node.default['haproxy']['backends']['share']['httpchk'] = "/share"
node.default['haproxy']['backends']['share']['nodes']['localhost'] = "127.0.0.1"
node.default['haproxy']['backends']['share']['port'] = 8081
node.default['haproxy']['redirects'] = ["redirect location /share/ if !is_share !is_alfresco !is_solr4 !is_aos_root !is_aos_vti"]

# Artifact Deployer attributes
node.default['artifacts']['share']['groupId']      = node['alfresco']['groupId']
node.default['artifacts']['share']['artifactId']   = "share"
node.default['artifacts']['share']['version']      = node['alfresco']['version']
node.default['artifacts']['share']['type']         = "war"
node.default['artifacts']['share']['destination']  = node['tomcat']['webapp_dir']
node.default['artifacts']['share']['owner']        = node['tomcat']['user']
node.default['artifacts']['share']['unzip']        = false

# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
node.default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share1']['priority'] = 52
node.default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.out.*'
node.default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share2']['priority'] = 53
