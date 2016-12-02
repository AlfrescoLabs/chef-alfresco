execute 'start_libreoffice' do
  command "#{node['alfresco']['properties']['jodconverter.officeHome']}program/soffice.bin #{node['libreoffice']['command']['full']}"
  user node['libreoffice']['user']
  group node['libreoffice']['user']
  returns 81
  creates node['libreoffice']['command']['user_installation_path']
  only_if { node['alfresco']['components'].include?('transform') }
  not_if { Mixlib::ShellOut.new('pgrep -f soffice.bin').run_command.exitstatus == 0 }
  notifies :delete, "directory[#{node['libreoffice']['command']['user_installation_path']}]", :immediately
  ignore_failure true
end

directory node['libreoffice']['command']['user_installation_path'] do
  recursive true
  action :nothing
  user node['libreoffice']['user']
  group node['libreoffice']['user']
end
