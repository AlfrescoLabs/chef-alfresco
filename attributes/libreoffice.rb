default['libreoffice']['initialise'] = false
default['libreoffice']['command']['host'] = '127.0.0.1'
default['libreoffice']['command']['accept'] = "\"--accept=socket,host=#{node['libreoffice']['command']['host']},port=#{node['alfresco']['properties']['jodconverter.portNumbers']};urp;\""
default['libreoffice']['command']['user_installation_path'] = "/var/cache/tomcat/alfresco/temp/.jodconverter_socket_host-#{node['libreoffice']['command']['host']}_port-#{node['alfresco']['properties']['jodconverter.portNumbers']}"
default['libreoffice']['command']['env'] = "-env:UserInstallation=file://#{node['libreoffice']['command']['user_installation_path']}"
default['libreoffice']['command']['params'] = '--headless --nocrashreport --nodefault --nofirststartwizard --nolockcheck --nologo --norestore'
default['libreoffice']['command']['full'] = "#{node['libreoffice']['command']['accept']} #{node['libreoffice']['command']['env']} #{node['libreoffice']['command']['params']}"
