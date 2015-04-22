include_recipe 'nginx::commons'

service 'nginx' do
  action :nothing
end
