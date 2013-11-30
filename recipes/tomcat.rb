include_recipe "tomcat::default"

require 'chef/rewind'

#This block overrides the :start default action (inherited by "tomcat" recipe) into :stop
#Tomcat service :restart action is notified at the end of every war (repo,share,solr) deployment
rewind :service => "tomcat" do
  case node["platform"]
  when "centos","redhat","fedora","amazon"
    service_name  "tomcat#{node["tomcat"]["base_version"]}"
    supports      :restart => true, :status => true
  when "debian","ubuntu"
    service_name  "tomcat#{node["tomcat"]["base_version"]}"
    supports      :restart => true, :reload => false, :status => true
  when "smartos"
    service_name  "tomcat"
    supports      :restart => true, :reload => false, :status => true
  else
    service_name "tomcat#{node["tomcat"]["base_version"]}"
  end
  action      [:enable, :stop]
  retries     4
  retry_delay 30
end