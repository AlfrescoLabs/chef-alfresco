node.default['artifacts']['_vti_bin']['enabled'] = true

unless node['alfresco']['version'].start_with?("5.1")
  node.default['artifacts']['aos-module']['enabled'] = true
else
  node.default['artifacts']['ROOT']['enabled'] = true
  node.default['haproxy']['frontends']['external']['acls']['aos_root'] = ["path_reg ^/$ method OPTIONS","path_reg ^/$ method PROPFIND"]
  node.default['haproxy']['backends']['roles']['aos_root']['entries'] = ["option httpchk GET /"]
  node.default['haproxy']['backends']['roles']['aos_root']['port'] = 8070

  node.default['haproxy']['frontends']['external']['redirects'] = [
    "redirect location /share/ if !is_share !is_alfresco !is_aos_root !is_aos_vti",
    "redirect location /share/ if is_root"
  ]

end
