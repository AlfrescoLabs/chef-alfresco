global_templates = node['tomcat']['global_templates']
if global_templates
  global_templates.each do |global_template|
    irectory global_template['dest'] do
      action :create
      recursive true
    end

    template "#{global_template['dest']}/#{global_template['filename']}" do
      source "tomcat/#{global_template['filename']}.erb"
      owner global_template['owner']
      group global_template['owner']
    end
  end
end

node['tomcat']['instances'].each do |tomcat_instance_name,tomcat_instance|
  instance_templates = node['tomcat']['instance_templates']

  instance_templates.each do |instance_template|
    directory instance_template['dest'] do
      action :create
      recursive true
    end

    template "#{instance_template['dest']}/#{tomcat_instance_name}-#{instance_template['filename']}" do
      source "tomcat/#{instance_template['filename']}.erb"
      owner instance_template['owner']
      group instance_template['owner']
      variables({
        :tomcat_log_path => "/var/log/tomcat-#{tomcat_instance_name}",
        :tomcat_cache_path => "/var/cache/tomcat-#{tomcat_instance_name}"
      })
    end
  end
end
