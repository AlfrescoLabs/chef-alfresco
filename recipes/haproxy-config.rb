haproxy_backends = node['haproxy']['backends'].to_hash.clone

# Define HaProxy local backends
node['alfresco']['components'].each do |component|
  if ['share','solr','repo'].include? component
    component = 'alfresco' if component == 'repo'
    id = "local_#{component}_backend"
    Ec2Discovery.setDeepAttribute(haproxy_backends,"roles/#{component}/az/local/id/#{id}",{})

    haproxy_backends['roles'][component]['az']['local']['id'][id]['id'] = id
    haproxy_backends['roles'][component]['az']['local']['id'][id]['ip'] = "127.0.0.1"
    haproxy_backends['roles'][component]['az']['local']['id'][id]['az'] = "local"
    haproxy_backends['roles'][component]['az']['local']['id'][id]['name'] = id
    haproxy_backends['roles'][component]['az']['local']['id'][id]['jvm_route'] = node['tomcat']['jvm_route']

    # Enable balancing for Share backend
    haproxy_backends['roles'][component]['balanced'] = true if component == 'share'
  end
end

# Duplicate alfresco backend into aos_vti, root and alfresco_api
haproxy_backends['aos_vti']['az'] = haproxy_backends['alfresco']['az']
haproxy_backends['aos_root']['az'] = haproxy_backends['alfresco']['az']
haproxy_backends['alfresco_api']['az'] = haproxy_backends['alfresco']['az']
haproxy_backends['webdav']['az'] = haproxy_backends['alfresco']['az']

if node['haproxy']['ec2_discovery_enabled']
  include_recipe 'alfresco::haproxy-ec2-discovery'
end

# Configure balancing and load distribution options on each instance:
# 1. If balancing=true on a given role, all instances will use jvm_route cookie
# to balance traffic
# 2. Otherwise, all server items of the given role, except the first,
# will be listed as backup
#
haproxy_backends['roles'].each do |roleName,role|
  balancing = role['balancing']
  options = "check cookie inter 5000"
  role['ordered_az'].each_with_index do |az,index|
    az['id'].each do |instanceName,instance|
      if balancing
        options = "check cookie #{instance['jvm_route']} inter 5000"
      elsif index > 0
        options = "check cookie inter 5000 backup"
      end
      instance['options'] = options
    end
  end
end

# TODO - make source/cookbook parametric
template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy/haproxy.cfg.erb'
  variables :haproxy_backends => haproxy_backends
  notifies :restart, 'service[haproxy]', :delayed
end
