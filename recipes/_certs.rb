filename = node['alfresco']['certs']['filename']
ssl_fqdn = node['alfresco']['certs']['ssl_fqdn']
ssl_folder = node['alfresco']['certs']['ssl_folder']
ssl_databag = node['alfresco']['certs']['ssl_databag']
ssl_databag_item = node['alfresco']['certs']['ssl_databag_item']

directory ssl_folder do
  action :create
  recursive true
end

begin
  ssl = data_bag_item(ssl_databag,ssl_databag_item)
  ssl.each do |ssl_item_name,ssl_item_value|
    unless ssl_item_name == "id"
      ssl_file = "#{ssl_folder}/#{filename}.#{ssl_item_name}"
      file ssl_file do
        action :create
        content ssl_item_value
        not_if { File.exist?(ssl_file) }
      end
    end
  end
rescue
  ssl_key_file = "#{ssl_folder}/#{filename}.key"
  ssl_crt_file = "#{ssl_folder}/#{filename}.crt"
  ssl_chain_file = "#{ssl_folder}/#{filename}.chain"
  ssl_nginxcrt_file = "#{ssl_folder}/#{filename}.nginxcrt"
  ssl_dhparam_file = "#{ssl_folder}/#{filename}.dhparam"

  unless node['alfresco']['skip_certificate_creation']
    execute "create-fake-ssl-keypair" do
      command "openssl req -subj '/C=UK/ST=Berkshire/L=Maidenhead/O=Alfresco/CN=#{ssl_fqdn}' -x509 -days 3650 -batch -nodes -newkey rsa:4096 -keyout #{ssl_key_file} -out #{ssl_crt_file}"
      not_if "test -f #{ssl_key_file}"
    end

    # TODO - .chain and .nginx are the same; use only .chain
    # TODO - ssh_trust_file should be created and concatenated to .chain file
    execute "create-chain-file" do
      command "echo '\n' >> #{ssl_crt_file}; cat #{ssl_crt_file} #{ssl_key_file} > #{ssl_chain_file}"
      not_if "test -f #{ssl_chain_file}"
    end
    execute "create-nginxcrt-file" do
      command "cat #{ssl_crt_file} #{ssl_key_file} > #{ssl_nginxcrt_file}"
      not_if "test -f #{ssl_nginxcrt_file}"
    end
    execute "create-dhparam-file" do
      command "openssl dhparam -out #{ssl_dhparam_file} 4096"
      not_if "test -f #{ssl_dhparam_file}"
    end
  end
end
