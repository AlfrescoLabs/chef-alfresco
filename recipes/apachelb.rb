apache_conf_folder  = node['lb']['apache_conf_folder']
service_name        = node['lb']['service_name']

template "httpd-proxy-balancer.conf" do
  path        "#{apache_conf_folder}/httpd-proxy-balancer.conf"
  source      "httpd-proxy-balancer.conf.erb"
  owner       "root"
  group       "root"
  mode        "0660"
end

service service_name do
	action [:enable, :restart]
end