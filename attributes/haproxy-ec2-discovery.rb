# Example of tag creation for the current box
# default['haproxy']['ec2']['box_tags']['status'] = "complete"
# default['haproxy']['ec2']['box_tags']['stack_name'] = "mystack"

# Example of query tag to discover other peers
# default['haproxy']['ec2']['query_tags']['status'] = "complete"
# default['haproxy']['ec2']['query_tags']['stack_name'] = "mystack"

default['haproxy']['ec2']['aws_bin'] = "aws"

# Peers are retrieved using aws commandline tool and stored in a local file
default['haproxy']['ec2']['peers_file_path'] = "/etc/chef/ec2-peers.json"

# Peers are grouped by role, based on the value of an EC2 Tag
default['haproxy']['ec2']['role_tag_name'] = "haproxy-role"
