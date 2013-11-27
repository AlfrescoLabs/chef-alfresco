include_recipe "apt::default"
include_recipe "xml::ruby"
include_recipe "java::default"
include_recipe "maven::default"

template "#{node['maven']['m2_home']}/conf/settings.xml" do
  source "settings.xml.erb"
  mode 0440
  owner "root"
  group "root"
end
