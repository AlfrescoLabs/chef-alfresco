execute 'start_libreoffice' do
  command "#{node['alfresco']['properties']['jodconverter.officeHome']}program/soffice.bin #{node['libreoffice']['command']['full']}"
  user node['libreoffice']['user']
  group node['libreoffice']['user']
  returns 81
  not_if { ::File.directory?(node['libreoffice']['command']['user_installation_path']) }
  notifies :delete, directory["#{node['libreoffice']['command']['user_installation_path']}"]
end

directory "#{node['libreoffice']['command']['user_installation_path']}" do
  recursive true
  action :nothing
  user node['libreoffice']['user']
  group node['libreoffice']['user']
end
