default['elasticsearch']['version'] = '1.4.4'
default['elasticsearch']['checksum'] = 'a3158d474e68520664debaea304be22327fc7ee1f410e0bfd940747b413e8586'

default['elasticsearch']['override_config']['cluster.name'] = "elasticsearch"
default['elasticsearch']['override_config']['node.name'] = "localhost"
default['elasticsearch']['override_config']['network.host'] = "0.0.0.0"
default['elasticsearch']['override_config']['node.master'] = true
default['elasticsearch']['override_config']['node.data'] = true
