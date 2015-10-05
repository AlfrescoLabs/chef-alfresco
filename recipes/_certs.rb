ssl_fqdn = node['alfresco']['certs']['ssl_fqdn']
ssl_folder = node['alfresco']['certs']['ssl_folder']
ssl_databag = node['alfresco']['certs']['ssl_databag']
ssl_databag_item = node['alfresco']['certs']['ssl_databag_item']

directory ssl_folder do
  action :create
  recursive true
end

begin
  Chef::Log.warn("Loading databag #{ssl_databag}, item #{ssl_databag_item}")

  ssl = data_bag_item(ssl_databag,ssl_databag_item)

  Chef::Log.warn("This is ssl _certs databag: #{ssl}")

  ssl.each do |ssl_item_name,ssl_item_value|
    Chef::Log.warn("ssl _certs entry: #{ssl_item_name}=#{ssl_item_value}")
    unless ssl_item_name == "id"
      ssl_file = "#{ssl_folder}/#{ssl_fqdn}.#{ssl_item_name}"
      file ssl_file do
        action :create
        content ssl_item_value
        not_if { File.exist?(ssl_file) }
      end
    end
  end
rescue
  ssl_key_file = "#{ssl_folder}/#{ssl_fqdn}.key"
  ssl_crt_file = "#{ssl_folder}/#{ssl_fqdn}.crt"
  ssl_pem_file = "#{ssl_folder}/#{ssl_fqdn}.pem"
  ssl_chain_file = "#{ssl_folder}/#{ssl_fqdn}.chain"
  ssl_dhparam_file = "#{ssl_folder}/#{ssl_fqdn}.dhparam"

  execute "create-fake-ssl-keypair" do
    command "sudo openssl req -subj '/C=UK/ST=Berkshire/L=Maidenhead/O=Alfresco/CN=#{ssl_fqdn}' -x509 -days 3650 -batch -nodes -newkey rsa:4096 -keyout #{ssl_key_file} -out #{ssl_crt_file}"
    not_if "test -f #{ssl_key_file}"
  end
  execute "create-pem-file" do
    command "cat #{ssl_key_file} #{ssl_crt_file} > #{ssl_pem_file}"
    not_if "test -f #{ssl_pem_file}"
  end
  execute "create-chain-file" do
    command "cat #{ssl_key_file} #{ssl_crt_file} > #{ssl_chain_file}"
    not_if "test -f #{ssl_chain_file}"
  end
  execute "create-dhparam-file" do
    command "openssl dhparam -out #{ssl_dhparam_file} 4096"
    not_if "test -f #{ssl_dhparam_file}"
  end

end
