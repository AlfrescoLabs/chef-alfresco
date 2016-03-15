resource_name :alfresco_service

property :service_name, String, name_property: true
property :autorestart, [TrueClass, FalseClass], default: true
property :autostart, [TrueClass, FalseClass], default: true
property :user, String, default: nil
property :directory, String, default: nil
property :command, String, default: "test"
property :environment, Hash, default: {}

default_action :nothing

action :create do

  include_recipe 'supervisor::default'
  service 'supervisor' do
    action :nothing
  end

  user new_resource.user
  command new_resource.command
  autorestart new_resource.autorestart
  autostart new_resource.autostart
  directory new_resource.directory
  environment new_resource.environment

  supervisor_service "#{service_name}" do
    command new_resource.command
    action :enable
    user new_resource.user
    autorestart new_resource.autorestart
    autostart new_resource.autostart
    directory new_resource.directory
    environment (new_resource.environment)
  end

end
