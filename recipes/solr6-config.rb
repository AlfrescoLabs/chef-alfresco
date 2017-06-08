# this recipe will run AFTER the artifact deployer - solr6 alfready downloaded

solr_home = node['solr6']['solr-in-sh']['SOLR_HOME']
solr_env_dir = node['solr6']['solr_env_dir']
installation_path = node['solr6']['installation-path']
alf_ss_id = node['artifacts']['alfresco-search-services']['artifactId']
alf_ss_path = "#{installation_path}/#{alf_ss_id}"
solr_pid_dir = node['solr6']['solr-in-sh']['SOLR_PID_DIR']
log4j_props = node['solr6']['solr-in-sh']['LOG4J_PROPS']
solr_user = node['solr6']['user']

# mv /opt/alfresco-search-services/alfresco-search-services/* /opt/alfresco-search-services
ruby_block 'copy Solr File to parent folder' do
  block do
    FileUtils.cp_r(Dir.glob("#{alf_ss_path}/#{alf_ss_id}/*"), alf_ss_path)
  end
  only_if { Dir.exist?("#{alf_ss_path}/#{alf_ss_id}") }
  notifies :delete, "directory[#{alf_ss_path}/#{alf_ss_id}]", :immediately
  action :run
end

# rm -rf /opt/alfresco-search-services/alfresco-search-services/
directory "#{alf_ss_path}/#{alf_ss_id}" do
  recursive true
  action :nothing
end

config_files = ["#{alf_ss_path}/solrhome/conf/shared.properties",
                "#{alf_ss_path}/solrhome/templates/rerank/conf/solrcore.properties"]

# replacing configuration files
config_files.each do |config_file|
  filename = File.basename(config_file)
  template config_file do
    source "solr6/#{filename}.erb"
    mode 00440
    action :create
  end
end

# creating solr_env_dir if it does not exist
directory solr_env_dir do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

template "#{solr_env_dir}/solr.in.sh" do
  source 'solr6/solr.in.sh.erb'
  mode 00644
  owner 'root'
  group 'root'
end

service 'solr' do
  action :nothing
  supports status: 'true', restart: 'true', start: 'true', stop: 'true'
end

directory solr_pid_dir do
  owner solr_user
  group solr_user
  mode 00750
  recursive true
  action :create
end

directory node['solr6']['solr-in-sh']['SOLR_LOGS_DIR'] do
  owner solr_user
  group solr_user
  mode 00750
  recursive true
  action :create
end

directory solr_home do
  owner solr_user
  group solr_user
  mode 00750
  recursive true
  action :create
end

# copying solrHome content to different location just if the old solrhome exists
ruby_block 'Copying solrhome into new location' do
  block do
    FileUtils.cp_r(Dir.glob("#{alf_ss_path}/solrhome/*"), solr_home)
  end
  only_if { Dir.exist?("#{alf_ss_path}/solrhome") }
  action :run
end

template log4j_props do
  source 'solr6/log4j.properties.erb'
  mode 00640
  owner solr_user
  group solr_user
end

files_to_delete = ["#{alf_ss_path}/solr.in.cmd", "#{alf_ss_path}/solr.in.sh"]
files_to_delete.each do |file_to_delete|
  file file_to_delete do
    action :delete
  end
end

dirs_to_delete = ["#{alf_ss_path}/solrhome", "#{alf_ss_path}/logs"]
dirs_to_delete.each do |dir_to_delete|
  directory dir_to_delete do
    recursive true
    action :delete
  end
end

cookbook_file "#{alf_ss_path}/solr/bin/solr" do
  source 'solr6/solr'
  owner 'root'
  group 'root'
  mode 00644
  action :create
end

execute 'change-solr6-permissions' do
  cwd alf_ss_path
  command <<-EOF
  chown -R root: "./solr"
  find "./solr" -type d -print0 | xargs -0 chmod 0755
  find "./solr" -type f -print0 | xargs -0 chmod 0644
  chmod -R 00755 "./solr/bin"
  chown -R #{solr_user}: "#{solr_home}"
  find "#{solr_pid_dir}" -type d -print0 | xargs -0 chmod 0755
  find "#{solr_pid_dir}" -type f ! -regex ".*\.\(xml\|properties\|txt\|html\|csv\|keystore\|truststore\)" -print0 | xargs -0 chmod 0640
  chmod 00640 "#{log4j_props}"
  EOF
end

# first start to create the Alfresco cores
template '/etc/init.d/solr' do
  source 'solr6/solr.erb'
  mode 00744
  owner 'root'
  # notifies :enable, 'service[solr]', :immediately
end
