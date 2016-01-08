load_current_value do
end

action :run do

  # Add error pages to external frontend
  error_folder = node['alfresco']['errorpages']['error_folder']
  %w( 400 403 408 500 502 503 504 ).each do |error_code|
    node.default['haproxy']['frontends']['external']['entries'] << "errorfile #{error_code} #{error_folder}/#{error_code}.http"
    node.default['haproxy']['frontends']['external']['entries'] << "acl is_#{error_code}_error status eq #{error_code}"
    node.default['haproxy']['frontends']['external']['entries'] << "rspideny . if is_#{error_code}_error"
  end

  haproxy_backends = node['haproxy']['backends']['roles'].to_hash.clone

  # Define HaProxy local backends
  node['alfresco']['components'].each do |component|
    if ['share','solr','repo'].include? component
      component = 'alfresco' if component == 'repo'
      id = "local_#{component}_backend"

      # Make sure the hash structure is created
      Ec2Discovery.setDeepAttribute(haproxy_backends,[component,'az','local','id',id],{})

      haproxy_backends[component]['az']['local']['id'][id]['id'] = id
      haproxy_backends[component]['az']['local']['id'][id]['ip'] = "127.0.0.1"
      haproxy_backends[component]['az']['local']['id'][id]['az'] = "local"
      haproxy_backends[component]['az']['local']['id'][id]['name'] = id
      haproxy_backends[component]['az']['local']['id'][id]['jvm_route'] = node['tomcat']['jvm_route']

      # Enable balancing for Share backend
      if component == 'share'
        haproxy_backends[component]['balanced'] = true
      else
        haproxy_backends[component]['balanced'] = false
      end
    end
  end

  if node['haproxy']['ec2']['discovery_enabled']
    # Run EC2 discovery
    ec2_discovery_output = Ec2Discovery.discover(node['commons']['ec2_discovery'])

    # Merge local and EC2 configuration entries
    haproxy_backends = Chef::Mixin::DeepMerge.merge(haproxy_backends,ec2_discovery_output['haproxy_backends'])
  end

  # Duplicate alfresco backend into aos_vti, root and alfresco_api
  haproxy_backends['aos_vti']['az'] = haproxy_backends['alfresco']['az']
  haproxy_backends['aos_root']['az'] = haproxy_backends['alfresco']['az']
  # TODO - WIP
  # haproxy_backends['alfresco_api']['az'] = haproxy_backends['alfresco']['az']
  # haproxy_backends['webdav']['az'] = haproxy_backends['alfresco']['az']

  # Order AZs as follows:
  # 1. Local
  # 2. Current AZ
  # 3. Others
  #
  current_az = haproxy_backends['current']['az'] if haproxy_backends['current']
  haproxy_backends.each do |roleName,role|
    if role['az']
      ordered_role = []
      ordered_role << role['az']['local'] if role['az']['local']
      ordered_role << role['az'][current_az] if current_az
      role['az'].each do |azName,az|
        if 'local' != azName and (current_az == nil or current_az != azName)
          ordered_role << az if az
        end
      end
      role['ordered_az'] = ordered_role
    end
  end

  # Configure balancing and load distribution options on each instance:
  # 1. If balancing=true on a given role, all instances will use jvm_route cookie
  # to balance traffic
  # 2. Otherwise, all server items of the given role, except the first,
  # will be listed as backup
  #
  haproxy_backends.each do |roleName,role|
    if role['ordered_az']
      balanced = role['balanced']
      options = "check inter 5000"
      role['ordered_az'].each_with_index do |az,index|
        az['id'].each do |instanceName,instance|
          if balanced
            options = "cookie #{instance['jvm_route']} check inter 5000"
          elsif index > 0
            options = "check inter 5000 backup"
          end
          instance['options'] = options
        end
      end
    end
  end

  template '/etc/haproxy/haproxy.cfg' do
    source 'haproxy/haproxy.cfg.erb'
    cookbook 'alfresco'
    variables ({:haproxy_backends => haproxy_backends })
    notifies :restart, 'service[haproxy]', :delayed
  end

  service 'haproxy' do
    action :nothing
  end

end
