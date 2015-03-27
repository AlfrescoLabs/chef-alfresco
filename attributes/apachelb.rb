#TODO - Not used ATM; move to Haproxy
default['lb']['service_name'] = "apache2"
default['lb']['apache_conf_folder'] = "/etc/apache2/mods-enabled"
default['lb']['modules_folder'] = "/usr/lib/apache2/modules"

default['lb']['balancers']['alfresco']['protocol'] = node['alfresco']['properties']['alfresco.protocol']
default['lb']['balancers']['alfresco']['host'] = node['alfresco']['properties']['alfresco.host']
default['lb']['balancers']['alfresco']['port'] = node['alfresco']['properties']['alfresco.port']

default['lb']['balancers']['share']['protocol'] = node['alfresco']['properties']['share.protocol']
default['lb']['balancers']['share']['host'] = node['alfresco']['properties']['share.host']
default['lb']['balancers']['share']['port'] = node['alfresco']['properties']['share.port']

default['lb']['balancers']['solr']['protocol'] = node['alfresco']['properties']['solr.protocol']
default['lb']['balancers']['solr']['host'] = node['alfresco']['properties']['solr.host']
default['lb']['balancers']['solr']['port'] = node['alfresco']['properties']['solr.port']
