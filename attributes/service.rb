default['supervisor']['inet_port']='localhost:11001'

default['supervisor']['systemd_service_enabled'] = true

default['supervisor']['tomcat']['user'] = "tomcat"

default['supervisor']['haproxy']['user'] = "root"
default['supervisor']['haproxy']['command'] = "/usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid"

default['supervisor']['nginx']['user'] = "root"
default['supervisor']['nginx']['command'] ="/usr/sbin/nginx -c /etc/nginx/nginx.conf"

#default['supervisor']['inet_username']
#default['supervisor']['inet_password']

#default['supervisor']['ctlplugins'] = ({
#   'superlance'=> 'supervisorserialrestart.controllerplugin:make_serialrestart_controllerplugin'
#   })
