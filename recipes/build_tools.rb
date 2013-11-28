include_recipe "apt::default"
include_recipe "xml::ruby"

chef_gem 'chef-rewind' do
  action :install
end
