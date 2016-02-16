default['elasticsearch']['version'] = '1.7.3'
default['elasticsearch']['checksum'] = 'af517611493374cfb2daa8897ae17e63e2efea4d0377d316baa351c1776a2bca'

default['elasticsearch']['override_config']['cluster.name'] = "elasticsearch"
default['elasticsearch']['override_config']['node.name'] = "localhost"
default['elasticsearch']['override_config']['network.host'] = "0.0.0.0"
default['elasticsearch']['override_config']['node.master'] = true
default['elasticsearch']['override_config']['node.data'] = true
