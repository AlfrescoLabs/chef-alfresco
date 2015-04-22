template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy/haproxy.cfg.erb'
  notifies :restart, 'service[haproxy]'
end

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
    notifies :restart, 'service[haproxy]'
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

service 'haproxy' do
  action :nothing
end
