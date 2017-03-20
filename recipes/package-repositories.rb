include_recipe 'yum-epel::default' if node['platform_family'] == 'rhel'
