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

ruby_block 'run-ec2-discovery' do
  block do
    # Run EC2 discovery
    ec2_discovery_output = Ec2Discovery.discover(node['commons']['ec2_discovery'])

    # Merge local and EC2 configuration entries
    haproxy_backends = Chef::Mixin::DeepMerge.merge(haproxy_backends,ec2_discovery_output['haproxy_backends'])

    # Duplicate alfresco backend into aos_vti, root and alfresco_api
    haproxy_backends['aos_vti']['az'] = haproxy_backends['alfresco']['az']
    haproxy_backends['aos_root']['az'] = haproxy_backends['alfresco']['az']
    haproxy_backends['alfresco_api']['az'] = haproxy_backends['alfresco']['az']
    haproxy_backends['webdav']['az'] = haproxy_backends['alfresco']['az']

    # Order AZs as follows:
    # 1. Local
    # 2. Current AZ
    # 3. Others
    #
    current_az = haproxy_backends['current']['az'] if haproxy_backends['current']
    haproxy_backends.each do |roleName,role|
      if role['az']
        ordered_role = []
        ordered_role << role['az']['local']
        ordered_role << role['az'][current_az] if current_az
        role['az'].each do |azName,az|
          if 'local' != azName and (current_az == nil or current_az != azName)
            ordered_role << az
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

      r = Chef::Resource::Template.new('haproxy.cfg', run_context)
      r.path '/etc/haproxy/haproxy.cfg'
      r.source 'haproxy/haproxy.cfg.erb'
      r.cookbook 'alfresco'
      r.variables :haproxy_backends => haproxy_backends
      r.run_action :create
      r.notifies :restart, 'service[haproxy]', :delayed
    end
  end
  action :run
  only_if { node['haproxy']['ec2']['discovery_enabled'] }
end

service 'haproxy' do
  action :nothing
end
