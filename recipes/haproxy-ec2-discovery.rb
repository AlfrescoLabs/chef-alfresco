# Run EC2 discovery
ec2_discovery_output = Ec2Discovery.discover(node['commons']['ec2-discovery'])
current_az = ec2_discovery_output['current']['az']

# Collect local haproxy configurations
haproxy_backends = node['haproxy']['backends'].to_hash.clone

# Merge local and EC2 configuration entries
haproxy_backends = haproxy_backends.merge(ec2_discovery_output)

# Create an ordered list of AZs:
# 1. Local
# 2. Current AZ
# 3. Others
#
haproxy_backends['roles'].each do |roleName,role|
  ordered_role = []
  ordered_role << haproxy_backends['roles'][roleName]['az']['local']
  ordered_role << haproxy_backends['roles'][roleName]['az']['current_az']
  role['az'].each do |azName,az|
    unless ['local',current_az].include? azName
      ordered_role << az
    end
  end
  role['ordered_az'] = ordered_role
end

# TODO - this should be done by haproxy.rb
# 
# Generate /etc/haproxy/haproxy.cfg
# template '/etc/haproxy/haproxy.cfg' do
#   source 'haproxy/haproxy.cfg.erb'
#   variables :haproxy_backends => haproxy_backends
#   notifies :restart, 'service[haproxy]', :delayed
# end
