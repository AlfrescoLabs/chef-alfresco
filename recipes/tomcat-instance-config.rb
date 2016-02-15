global_templates = node['tomcat']['global_templates']
if global_templates
  global_templates.each do |global_template|
    directory global_template['dest'] do
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
