haproxy_cfg_source = node['haproxy']['conf_template_source']
haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']
error_file_cookbook = node['haproxy']['error_file_cookbook']
error_file_source = node['haproxy']['error_file_source']
error_folder = node['haproxy']['error_folder']

ssl_fqdn = node['haproxy']['ssl_fqdn']
ssl_key_file = node['haproxy']['ssl_key_file']
ssl_crt_file = node['haproxy']['ssl_crt_file']
ssl_pem_file = node['haproxy']['ssl_pem_file']
ssl_databag = node['haproxy']['ssl_databag']
ssl_databag_item = node['haproxy']['ssl_databag_item']

directory error_folder do
  action :create
  recursive true
end

%w( 400 403 404 408 500 502 503 504 ).each do |error_code|
  template "#{error_folder}/#{error_code}.http" do
    cookbook error_file_cookbook
    source "#{error_file_source}/#{error_code}.http.erb"
  end
end

directory File.dirname(ssl_key_file) do
  action :create
  recursive true
  only_if { ssl_key_file }
end

directory File.dirname(ssl_crt_file) do
  action :create
  recursive true
  only_if { ssl_crt_file }
end

begin
  ssl = data_bag_item(ssl_databag,ssl_databag_item)
  file ssl_key_file do
    action :create
    content ssl['key']
    not_if { File.exist?(ssl_key_file) }
  end
  file ssl_crt_file do
    action :create
    content ssl['crt']
    not_if { File.exist?(ssl_crt_file) }
  end
  file ssl_pem_file do
    action :create
    content "#{ssl['cert']}\n#{ssl['key']}"
    not_if { File.exist?(ssl_pem_file) }
  end
rescue
  execute "create-fake-haproxy-ssl-keypair" do
    command "sudo openssl req -subj '/CN=#{ssl_fqdn}/' -x509 -days 3650 -batch -nodes -newkey rsa:4096 -keyout #{ssl_key_file} -out #{ssl_crt_file}"
    not_if "test -f #{ssl_key_file}"
  end
  execute "create-pem-file" do
    command "cat #{ssl_key_file} #{ssl_crt_file} > #{ssl_pem_file}"
    not_if "test -f #{ssl_pem_file}"
  end
end

include_recipe 'haproxy::default'

# Set haproxy.cfg custom template
# TODO - fix it upstream and send PR
r = resources(template: "#{node['haproxy']['conf_dir']}/haproxy.cfg")
r.source(haproxy_cfg_source)
r.cookbook(haproxy_cfg_cookbook)
