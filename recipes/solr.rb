maven_repos             = node['alfresco']['maven']['repos']
root_dir                = node['alfresco']['root_dir']
alfresco_user           = node['tomcat']['user']
alfresco_group          = node['tomcat']['group']

solr_warpath            = node['alfresco']['solr']['war_path']
solr_filename           = node['alfresco']['solr']['war_filename']

solr_conf_groupId       = node['alfresco']['solrconf']['groupId']
solr_conf_artifactId    = node['alfresco']['solrconf']['artifactId']
solr_conf_version       = node['alfresco']['solrconf']['version']

webapp_dir              = node['tomcat']['webapp_dir']
context_dir             = node['tomcat']['context_dir']
cache_path              = Chef::Config['file_cache_path']

require 'nokogiri'

# Download Solr configuration artifact in Chef cache
maven "solr-conf" do
  artifact_id   solr_conf_artifactId
  group_id      solr_conf_groupId
  version       solr_conf_version
  action        :install
  dest          cache_path
  owner         alfresco_user
  packaging     'zip'
  repositories  maven_repos
end

# Unpacks Solr configuration (solr_home) in {root_dir} (i.e. /srv/alfresco/alf_data/solr_home)
ark "solr_home" do
  url               "file://#{cache_path}/#{solr_conf_artifactId}-#{solr_conf_version}.zip"
  path              root_dir
  owner             alfresco_user
  action            :put
  strip_leading_dir false
  append_env_path   false
  subscribes        :put, "maven[solr-conf]", :immediately
end

# Sets solrcore.properties for workspace using a template
template "solr-conf-workspace" do
  path        "#{root_dir}/solr_home/workspace-SpacesStore/conf/solrcore.properties"
  source      "solrcore.properties.workspace.erb"
  owner       alfresco_user
  mode        "0640"
  subscribes  :create, "ark[solr_home]", :immediately
end

# Sets solrcore.properties for archive using a template
template "solr-conf-archive" do
  path        "#{root_dir}/solr_home/archive-SpacesStore/conf/solrcore.properties"
  source      "solrcore.properties.archive.erb"
  owner       alfresco_user
  mode        "0640"
  subscribes  :create, "template[solr-conf-workspace]", :immediately
end

if !solr_warpath.nil?
  # Deploy the war file as it is
  ruby_block "deploy-solr-warpath" do
    block do
      require 'fileutils'
      FileUtils.cp "#{solr_warpath}","#{webapp_dir}/"
    end
    subscribes :create, "ruby-block[patch-solr-webxml]", :immediately
  end  
else
  # Unpack Solr configuration artifact in Chef cache, patch web.xml and log4j.properties
  ark "solr" do
    url               "file://#{root_dir}/solr_home/#{solr_filename}"
    path              cache_path
    owner             alfresco_user
    action            :put
    strip_leading_dir false
    append_env_path   false
    subscribes        :put, "template[solr-conf-archive]", :immediately
  end

  template "solr-log4j" do
    path        "#{cache_path}/solr/WEB-INF/classes/log4j.properties"
    source      "solr-log4j.properties.erb"
    owner       alfresco_user
    mode        "0640"
    subscribes  :create, "ark[solr]", :immediately
  end

  ruby_block "patch-solr-webxml" do
    block do
      file = File.open("#{cache_path}/solr/WEB-INF/web.xml", "r")
      content = file.read
      file.close
      node = Nokogiri::HTML::DocumentFragment.parse(content)
      node.search(".//security-constraint").remove
      content = node.to_html(:encoding => 'UTF-8', :indent => 2)    
      file = File.open("#{cache_path}/solr/WEB-INF/web.xml", "w")
      file.write(content)
      file.close unless file == nil    
    end
    subscribes :create, "template[solr-log4j]", :immediately
  end

  ruby_block "deploy-solr" do
    block do
      require 'fileutils'
      FileUtils.rm_rf "#{cache_path}/solr/solr"
      FileUtils.rm_rf "#{root_dir}/solr_home/solr_home"
      FileUtils.cp_r "#{cache_path}/solr","#{webapp_dir}/solr"
    end
    subscribes :create, "ruby-block[patch-solr-webxml]", :immediately
  end
end

template "#{context_dir}/solr.xml" do
  source      "solr.xml.erb"
  owner       alfresco_user
  mode        "0640"
  subscribes  :create, "ruby-block[deploy-solr]", :immediately
  subscribes  :create, "ruby-block[deploy-solr-warpath]", :immediately
  notifies    :restart, "service[tomcat]"
end
