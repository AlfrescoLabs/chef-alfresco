default['haproxy']['ec2']['discovery_enabled'] = false

default['haproxy']['ec2']['discovery_chef_erb'] = "/etc/cron.d/haproxy-discovery.cron"
default['haproxy']['ec2']['discovery_chef_json'] = "/etc/chef/haproxy-discovery.json"

# Following attributes are only used to build haproxy-discovery.json
#
# Define it at bootstrap time
# default['commons']['ec2_discovery']['query_tags']['status'] = "complete"
# default['commons']['ec2_discovery']['query_tags']['stack_name'] = "mystack"

default['commons']['ec2_discovery']['group_by'] = ['haproxy_backends','az','id']

default['commons']['ec2_discovery']['filter_in']['state'] = "running"
default['commons']['ec2_discovery']['filter_out']['current_ip'] = true

default['commons']['ec2_discovery']['output']['elements']['state'] = 'State/Name'
default['commons']['ec2_discovery']['output']['elements']['id'] = 'InstanceId'
default['commons']['ec2_discovery']['output']['elements']['ip'] = "PrivateIpAddress"
default['commons']['ec2_discovery']['output']['elements']['az'] = 'Placement/AvailabilityZone'
default['commons']['ec2_discovery']['output']['tags']['haproxy_backends'] = 'haproxy_backends'
default['commons']['ec2_discovery']['output']['tags']['instance_name'] = 'Name'
default['commons']['ec2_discovery']['output']['tags']['jvm_route'] = 'jvm_route'

# You'll probably need to also add the following in your Chef attributes:
#
# default['commons']['ec2_tags']['haproxy_backends'] = 'alfresco,share,solr'
# default['commons']['ec2_tags']['instance_name'] = 'my-instance-name1'
# default['commons']['ec2_tags']['jvm_route'] = 'n1'
