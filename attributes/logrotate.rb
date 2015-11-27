default['logrotate']['global']['rotate'] = 2
default['logrotate']['global']['compress'] = true
default['logrotate']['global']['daily'] = true
default['logrotate']['global']['missingok'] = true

default['logrotate']['global']['/var/log/haproxy/*.log'] = {
  'postrotate'  => ['[ -f /var/run/syslogd.pid ] && kill -USR1 `cat /var/run/syslogd.pid`']
}

default['logrotate']['global']['/var/log/nginx/*.log'] = {
  'delaycompress'  => true,
  'notifempty' => true,
  'sharedscripts' => true,
  'create' => '600 nginx nginx',
  'postrotate' => ['[ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`']
}
