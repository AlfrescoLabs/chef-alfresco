node.set['alfresco']['properties']['solr.port'] = node['haproxy']['port']
node.set['alfresco']['solrproperties']['alfresco.port'] = node['haproxy']['port']
node.set['alfresco']['shareproperties']['alfresco.port'] = node['haproxy']['port']

haproxy_cfg_source = node['haproxy']['conf_template_source']
haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']
error_file_cookbook = node['haproxy']['error_file_cookbook']
error_file_source = node['haproxy']['error_file_source']
error_folder = node['haproxy']['error_folder']

%w( 400 403 404 408 500 502 503 504 ).each do |error_code|
  template "#{error_folder}/#{error_code}.http" do
    cookbook error_file_cookbook
    source "#{error_file_source}/#{error_code}.http.erb"
  end
end

# TODO - SSL Logic is not tested; we need to come up with a common strategy for SSL
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

include_recipe 'haproxy::default'

# Set haproxy.cfg custom template
# TODO - fix it upstream and send PR
r = resources(template: "#{node['haproxy']['conf_dir']}/haproxy.cfg")
r.source(haproxy_cfg_source)
r.cookbook(haproxy_cfg_cookbook)
