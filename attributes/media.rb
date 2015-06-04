default['alfresco']['properties']['messaging.broker.url'] = "tcp://localhost:61616"

# TODO - there's no default location publicly available,
# since artifacts.alfresco.com doesn't contain media-management yet
default['artifacts']['media']['destination'] = '/opt'
default['artifacts']['media']['unzip'] = true
default['artifacts']['media']['type'] = "zip"

default['media']['content_services_pid_path'] = "/var/run/alfresco-content-services"
default['media']['content_services_log_path'] = "/var/log/alfresco-content-services"
default['media']['content_services_content_path'] = "#{node['artifacts']['media']['destination']}/media/AlfrescoContentServices"
default['media']['content_services_config_path'] = "#{node['artifacts']['media']['destination']}/media/config.yml"
default['media']['content_services_user'] =  "alfresco-content-services"

default['media']['content_services_app_port'] = 8888
default['media']['content_services_admin_port'] = 8889
