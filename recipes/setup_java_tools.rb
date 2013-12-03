include_recipe "java::set_java_home"

template  "#{node['maven']['m2_home']}/conf/settings.xml" do
  source  "settings.xml.erb"
  mode    0440
  owner   "root"
  group   "root"
end

#Copied from https://github.com/opscode-cookbooks/tomcat/blob/360c62fcbe07987f3802913dc70c7ec8ebcdf4fa/recipes/default.rb
case node["platform"]
when "centos","redhat","fedora","amazon"
  template "/etc/sysconfig/tomcat#{node["tomcat"]["base_version"]}" do
    source "sysconfig_tomcat6.erb"
    owner "root"
    group "root"
    mode "0644"
  end
when "smartos"
else
  template "/etc/default/tomcat#{node["tomcat"]["base_version"]}" do
    #Copied from https://github.com/opscode-cookbooks/tomcat/blob/360c62fcbe07987f3802913dc70c7ec8ebcdf4fa/templates/default/default_tomcat6.erb
    source "default_tomcat.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end