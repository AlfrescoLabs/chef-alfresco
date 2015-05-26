if node['platform_family'] == "rhel"
  include_recipe 'yum-epel::default'
  include_recipe 'yum-repoforge::default'
  # Used for libmp3lame0 package
  include_recipe 'yum-atrpms::default'
end
