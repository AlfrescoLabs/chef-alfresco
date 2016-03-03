node.default['artifacts']['_vti_bin']['enabled'] = true
node.default['artifacts']['ROOT']['enabled'] = true

if node['alfresco']['version'].start_with?("5.1")
  node.default['artifacts']['aos-module']['enabled'] = true
end
