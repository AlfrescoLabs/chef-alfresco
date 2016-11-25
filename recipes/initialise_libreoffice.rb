execute 'initialise_libreoffice' do
  command "(#{node['alfresco']['properties']['jodconverter.officeHome']}program/soffice.bin #{node['libreoffice']['command']['full']};rm -rf #{node['libreoffice']['command']['user_installation_path']}) &"
  user node['libreoffice']['user']
  group node['libreoffice']['user']
  not_if { ::File.directory?(node['libreoffice']['command']['user_installation_path']) }
end
