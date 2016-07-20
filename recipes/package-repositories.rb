if node['platform_family'] == "rhel"
  node.default['yum']['rpmforge']['enabled'] = false
  node.default['yum']['rpmforge']['managed'] = true
  node.default['yum']['rpmforge-extras']['enabled'] = false
  node.default['yum']['rpmforge-extras']['managed'] = true
  node.default['yum']['rpmforge-testing']['enabled'] = false
  node.default['yum']['rpmforge-testing']['managed'] = true
  include_recipe 'yum-repoforge::default'
  include_recipe 'yum-epel::default'
end
