default['transformations']['libreoffice']['tomcat_user'] = node['appserver']['user']
default['transformations']['libreoffice']['temp_folder'] = lazy { "#{node['alfresco']['home']}/alfresco/temp" }
