# Nginx settings
default['nginx']['service_actions'] = [:enable, :start]
default['nginx']['repo_source'] = 'nginx'
default['nginx']['upstream_repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
default['nginx']['client_max_body_size'] = 0
default['nginx']['proxy_read_timeout'] = 600
default['nginx']['keepalive_timeout'] = 120
default['nginx']['server_tokens'] = 'off'
default['nginx']['gzip_comp_level'] = 6
default['nginx']['gzip_http_version'] = '1.1'
default['nginx']['gzip_buffers'] = '16 8k'
default['nginx']['gzip_types'] = ['text/plain','text/css','text/javascript','application/x-javascript','application/javascript','application/ecmascript','application/rss+xml','application/atomsvc+xml','application/atom+xml','application/cmisquery+xml','application/cmisallowableactions+xml','application/cmisatom+xml','application/cmistree+xml','application/cmisacl+xml','application/msword','application/vnd.ms-excel','application/vnd.ms-powerpoint','application/json']
default['nginx']['port'] = '81'

# TODO nginx missing settings compared to what we have in use
# ignore_invalid_headers    on;
# max_ranges                0;   # disabled to stop range header DoS attacks
# output_buffers            1 512;
# reset_timedout_connection on;  # reset timed out connections freeing ram
# server_name_in_redirect   off; # if off, nginx will use the requested Host header
