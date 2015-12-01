# This recipe aims to help discovery process in EC2; it runs AWS commandline
# with 2 objectives:
# 1. Discovers other machines, depending on their tags and delivers a list
# of IPs/urls that are ready to be configured in HAproxy
# 2. Tag the current box on EC2 so that it can be discovered by others
#
# AWS commandline tool is provided by artifact-deployer
#
query_tags = node['haproxy']['ec2']['query_tags']
box_tags = node['haproxy']['ec2']['box_tags']
peers_file_path = node['haproxy']['ec2']['peers_file_path']
role_tag_name = node['haproxy']['ec2']['role_tag_name']
aws_bin = node['haproxy']['ec2']['aws_bin']

#TODO - use aws cookbook
# aws_resource_tag node['ec2']['instance_id'] do
#   aws_access_key aws['aws_access_key_id']
#   aws_secret_access_key aws['aws_secret_access_key']
#   tags({"Name" => "www.example.com app server",
#         "Environment" => node.chef_environment})
#   action :update
# end

# Query AWS instances and set node attributes for haproxy service discovery configuration
if query_tags
  query_tag_filter = ""
  query_tags.each do |tagName,tagValue|
    query_tag_filter += "--filters Name=tag:#{tagName},Values=#{tagValue} "
  end

  execute "create-ec2-peers-json" do
    command "#{aws_bin} ec2 describe-instances #{query_tag_filter} > #{peers_file_path}"
    # re-create it every time
    # creates peers_file_path
  end

  # Fetching current availability_zone
  availability_zone_command = "wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone"

  private_ip_command = "wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4"

  execute "set-ec2-availability-zone" do
    command "#{availability_zone_command} > /etc/chef/availability-zone"
  end

  execute "set-ec2-private-ip" do
    command "#{private_ip_command} > /etc/chef/private-ip"
  end

  # TODO - refactor with:
  # aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output text --filters Name=tag:Status,Values=complete
  haproxy_backends = node['haproxy']['backends'].to_hash.clone
  ruby_block "handling-#{peers_file_path}" do
    block do
      file = File.read(peers_file_path)
      current_availability_zone = File.read('/etc/chef/availability-zone')
      current_private_ip = File.read('/etc/chef/private-ip')
      peers_hash = JSON.parse(file)
      Chef::Log.info("Parsing EC2 instances for current avaliability zone '#{current_availability_zone}'; Role Tag Name is '#{role_tag_name}'")

      if peers_hash['Reservations'] and peers_hash['Reservations'].length > 0
        Chef::Log.info("Found EC2 #{peers_hash['Reservations'].size()} instances")
        peers_hash['Reservations'].each do |reservation|
          reservation['Instances'].each do |awsnode|
            private_ip = awsnode['PrivateIpAddress']
            availability_zone = awsnode['Placement']['AvailabilityZone']
            status = awsnode['State']['Name']
            id = awsnode['InstanceId']
            Chef::Log.info("Parsing EC2 instance '#{id}', status '#{status}', avaliability zone '#{availability_zone}', private IP '#{private_ip}'")
            if status == "running"
              awsnode['Tags'].each do |tag|
                if tag['Key'] == role_tag_name
                  role = tag['Value']
                  Chef::Log.info("EC2 instance '#{id}' has role '#{role}'")
                  unless haproxy_backends[role]
                    haproxy_backends[role] = {}
                    haproxy_backends[role]['zones'] = {}
                  end
                  unless haproxy_backends[role]['zones'][availability_zone]
                    haproxy_backends[role]['zones'][availability_zone] = {}
                    haproxy_backends[role]['zones'][availability_zone]['nodes'] = {}
                  end
                  if current_availability_zone == availability_zone
		                  haproxy_backends[role]['zones'][availability_zone]['current'] = true
                  end

                  unless current_private_ip == private_ip
  		              haproxy_backends[role]['zones'][availability_zone]['nodes'][id] = private_ip
                    Chef::Log.info("haproxy-ec2-discovery: Discovered node with ip '#{private_ip}', role '#{role}' and availability_zone '#{availability_zone}'")
                  else
                    Chef::Log.info("Skipping instance #{private_ip} as it's the current instance")
                  end
                end
              end
            end
          end
        end
      end

      if haproxy_backends['allinone']
        haproxy_backends['alfresco']['zones'] = haproxy_backends['allinone']['zones']
        haproxy_backends['share']['zones'] = haproxy_backends['allinone']['zones']
        haproxy_backends['solr']['zones'] = haproxy_backends['allinone']['zones']
      end

	    # AOS backend is hosted by alfresco, so it inherits same haproxy configurations
      if haproxy_backends['alfresco'] and haproxy_backends['aos_vti'] and haproxy_backends['aos_root']
        haproxy_backends['aos_vti']['zones'] = haproxy_backends['alfresco']['zones']
        haproxy_backends['aos_root']['zones'] = haproxy_backends['alfresco']['zones']
      end

      Chef::Log.info("Haproxy backends: #{haproxy_backends}")

    end
    action :run
  end

  # TODO - make source/cookbook parametric
  template '/etc/haproxy/haproxy.cfg' do
    source 'haproxy/haproxy.cfg.erb'
    variables :haproxy_backends => haproxy_backends
    notifies :restart, 'service[haproxy]', :delayed
  end

  service 'haproxy' do
    action :nothing
  end
end

# Set tags on the box
if box_tags
  box_tags_str = "--tags "
  instance_id_command = "$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)"
  box_tags.each do |tagName,tagValue|
    box_tags_str += "Key=#{tagName},Value=#{tagValue} "
  end
  execute "set-ec2-tags" do
    command "#{aws_bin} ec2 create-tags --resources #{instance_id_command} #{box_tags_str}"
  end
end
