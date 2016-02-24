if node['platform_family'] == "rhel"
  include_recipe 'yum-epel::default'
  include_recipe 'yum-repoforge::default'
end
