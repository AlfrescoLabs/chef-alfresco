# This recipe aims to help discovery process in EC2; it runs AWS commandline
# with 2 objectives:
# 1. Discovers other machines, depending on their tags and delivers a list
# of IPs/urls that are ready to be configured in HAproxy
# 2. Tag the current box on EC2 so that it can be discovered by others
#
# AWS commandline tool is provided by artifact-deployer
#
query_tags = node['ec2']['query_tags']
box_tags = node['ec2']['box_tags']
peers_file_path = node['ec2']['peers_file_path']
role_tag_name = node['ec2']['role_tag_name']
aws_bin = node['ec2']['aws_bin']

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

  ruby_block "handling-#{peers_file_path}" do
    block do
      file = File.read(peers_file_path)
      peers_hash = JSON.parse(file)
      if peers_hash['Reservations']
        peers_hash['Reservations']['Instances'].each do |node|
          private_ip = node['PrivateIpAddress']
          status = node['State']['Name']
          id = node['InstanceId']
          peer_item = {"id" => id, "ip" => private_ip}

          if status != "running"
            node['Tags'].each do |tag|
              if tag['Key'] == role_tag_name
                role = tag['Value']
                node.default['haproxy']['backends'][role]['nodes'] << peer_item
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
end

# Set tags on the box
if box_tags
  box_tags_str = ""
  instance_id_command = "$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)"
  box_tags.each do |tagName,tagValue|
    box_tags_str += "--tags Key=#{tagName},Value=#{tagValue} "
  end
  execute "set-ec2-tags" do
    command "#{aws_bin} ec2 create-tags --resources #{instance_id_command} #{box_tags_str}"
  end
end
