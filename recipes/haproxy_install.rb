haproxy_cfg_source = node['haproxy']['conf_template_source']
haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']
error_file_cookbook = node['haproxy']['error_file_cookbook']
error_file_source = node['haproxy']['error_file_source']
error_folder = node['haproxy']['error_folder']

remote_directory error_folder do
  cookbook error_file_cookbook
  source error_file_source
end

ssl_pem_crt_file = node['haproxy']['ssl_pem_crt_file']
ssl_pem_crt_databag = node['haproxy']['ssl_pem_crt_databag']
ssl_pem_crt_databag_item = node['haproxy']['ssl_pem_crt_databag_item']

directory File.dirname(ssl_pem_crt_file) do
  action :create
  recursive true
end

begin
  ssl_pem_crt = data_bag_item(ssl_pem_crt_databag,ssl_pem_crt_databag_item)
  file ssl_pem_crt_file do
    action :create
    content ssl_pem_crt['pem']
  end
rescue
  execute "create-fake-haproxy.pem" do
    command "openssl req \
      -new -newkey rsa:4096 \
      -days 365 -nodes \
      -subj \"/C=US/ST=this-certificate/L=is/O=used/CN=by-haproxy\" \
      -keyout #{ssl_pem_crt_file} \
      -out /tmp/csr-haproxy.pem"
    not_if "test -f #{ssl_pem_crt_file}"
  end
end

# Using AWS EC2 tags to discover services
backend_config = []
peer_nodes = node['haproxy']['peers']
if peer_nodes
  peer_nodes.each do |backend|
    httpchk = backend['httpchk']
    backend_config += "backend #{backend}"
    if httpchk
      backend_config += "option httpchk GET #{httpchk}"
    end
    backend['nodes'].each do |node|
      backend_config += "server <%= node['id'] %> <%= node['ip'] %>:<%= backend['port'] %> check inter 5000"
    end
  end

  haproxy_config = node['haproxy']['config']
  node.default['haproxy']['config'] = haproxy_config + backend_config
end

include_recipe 'haproxy::default'

# Set haproxy.cfg custom template
# TODO - fix it upstream and send PR
r = resources(template: "#{node['haproxy']['conf_dir']}/haproxy.cfg")
r.source(haproxy_cfg_source)
r.cookbook(haproxy_cfg_cookbook)
