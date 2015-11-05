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

  execute "set-ec2-availability-zone" do
    command "#{availability_zone_command} > /etc/chef/availability-zone"
  end

  # TODO - refactor with:
  # aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output text --filters Name=tag:Status,Values=complete
  ruby_block "handling-#{peers_file_path}" do
    block do
      file = File.read(peers_file_path)
      current_availability_zone = File.read('/etc/chef/availability-zone')
      peers_hash = JSON.parse(file)
      if peers_hash['Reservations'] and peers_hash['Reservations'].length > 0
        peers_hash['Reservations'].each do |reservation|
          reservation['Instances'].each do |awsnode|
            private_ip = awsnode['PrivateIpAddress']
            availability_zone = awsnode['Placement']['AvailabilityZone']
            status = awsnode['State']['Name']
            id = awsnode['InstanceId']
            if status == "running"
              awsnode['Tags'].each do |tag|
                if tag['Key'] == role_tag_name
                  role = tag['Value']
                  if current_availability_zone == availability_zone
                    node.default['haproxy']['backends'][role]['nodes'][availability_zone]['current'] = true
                  end
                  node.default['haproxy']['backends'][role]['nodes'][availability_zone][id] = private_ip
                  Chef::Log.info("haproxy-ec2-discovery: Discovered node with ip '#{private_ip}', role '#{role}' and availability_zone '#{availability_zone}'")
                end
              end
            end
          end
        end
      end

      # AOS backend is hosted by alfresco, so it inherits same haproxy configurations
      node.default['haproxy']['backends']['aos_vti']['nodes'] = node['haproxy']['backends']['alfresco']['nodes']
      node.default['haproxy']['backends']['aos_root']['nodes'] = node['haproxy']['backends']['alfresco']['nodes']
    end
    action :run
  end

  template '/etc/haproxy/haproxy.cfg' do
    source 'haproxy/haproxy.cfg.erb'
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
