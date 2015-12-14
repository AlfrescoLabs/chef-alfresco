default['haproxy']['ec2_discovery_enabled'] = false

default['haproxy']['ec2']['discovery_chef_erb'] = "/etc/cron.d/haproxy-discovery.cron"
default['haproxy']['ec2']['discovery_chef_json'] = "/etc/chef/haproxy-discovery.json"
