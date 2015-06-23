# When discovering peer nodes for haproxy configuration, use the following tags
# default['ec2']['query_tags']['status'] = "complete"

# Sets tag "Status=complete" on AWS as soon as provisioning is complete
# default['ec2']['box_tags']['status'] = "complete"

default['ec2']['aws_bin'] = "aws"

# Peers are retrieved using aws commandline tool and stored in a local file
default['ec2']['peers_file_path'] = "/etc/chef/ec2-peers.json"

# Peers are grouped by role, based on the value of an EC2 Tag
default['ec2']['role_tag_name'] = "haproxy-role"
