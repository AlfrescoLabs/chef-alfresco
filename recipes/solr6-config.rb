# this recipe will run AFTER the artifact deployer - solr6 alfready downloaded

solr_home = node['solr6']['solr-in-sh']['SOLR_HOME']
solr_env_dir = node['solr6']['solr_env_dir']
installation_path = node['solr6']['installation-path']
destinationName = node['solr6']['dir_name']
alf_ss_path = "#{installation_path}/#{destinationName}"
solr_pid_dir = node['solr6']['solr-in-sh']['SOLR_PID_DIR']
log4j_props = node['solr6']['solr-in-sh']['LOG4J_PROPS']
solr_user = node['solr6']['user']

config_files = ["#{alf_ss_path}/solrhome/conf/shared.properties",
                "#{alf_ss_path}/solrhome/templates/rerank/conf/solrcore.properties"
]

# replacing configuration files
config_files.each do |config_file|

  file config_file do
    action :delete
  end

  filename = File.basename(config_file)

  template config_file do
    source "solr6/#{filename}.erb"
    mode '0440'
  end
end

# creating solr_env_dir if it does not exist
directory solr_env_dir do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
  action :create
end

template "#{solr_env_dir}/solr.in.sh" do
  source "solr6/solr.in.sh.erb"
  mode 0644
  owner 'root'
  group 'root'
end

service 'solr' do
  action :nothing
  supports :status => true, :restart => true, :start => true, :stop => true
end

directory solr_pid_dir do
  owner solr_user
  group solr_user
  mode 0750
  recursive true
  action :create
end

directory node['solr6']['solr-in-sh']['SOLR_LOGS_DIR'] do
  owner solr_user
  group solr_user
  mode 0750
  recursive true
  action :create
end

directory solr_home do
  owner solr_user
  group solr_user
  mode 0750
  recursive true
  action :create
end

# copying solrHome to different location just if the target recipe is empty
execute "Copying solrhome into new location" do
  command <<-EOF
    cp -R #{alf_ss_path}/solrhome/* #{solr_home}
  EOF
  only_if { (Dir.entries(solr_home) - %w{ . .. }).empty? }
end

template log4j_props do
  source "solr6/log4j.properties.erb"
  mode 0640
  owner solr_user
  group solr_user
end

files_to_delete = ["#{alf_ss_path}/solr.in.cmd","#{alf_ss_path}/solr.in.sh"]
files_to_delete.each do |file_to_delete|
  file file_to_delete do
    action :delete
  end
end

dirs_to_delete = ["#{alf_ss_path}/solrhome","#{alf_ss_path}/logs"]
dirs_to_delete.each do |dir_to_delete|
  directory dir_to_delete do
    recursive true
    action :delete
  end
end

execute 'change-solr6-permissions' do
  cwd alf_ss_path
  command <<-EOF
  chown -R root: "./solr"
  find "./solr" -type d -print0 | xargs -0 chmod 0755
  find "./solr" -type f -print0 | xargs -0 chmod 0644
  chmod -R 0755 "./solr/bin"
  chown -R #{solr_user}: "#{solr_home}"
  find "#{solr_home}" -type d -print0 | xargs -0 chmod 0755
  find "#{solr_home}" -type f -print0 | xargs -0 chmod 0440
  chmod 0640 "#{log4j_props}"
  EOF
end

# first start to create the Alfresco cores
template '/etc/init.d/solr' do
  source "solr6/solr.erb"
  mode 0744
  owner 'root'
  notifies :enable, "service[solr]"
  notifies :start, "service[solr]"
end
