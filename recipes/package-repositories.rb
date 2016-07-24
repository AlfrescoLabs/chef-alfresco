if node['platform_family'] == "rhel"
  include_recipe 'yum-epel::default'
end
