resource_name :alfresco_service

property :service_name, String, name_property: true
property :enabled, [TrueClass, FalseClass], default: false
property :autorestart, [TrueClass, FalseClass], default: true
property :autostart, [TrueClass, FalseClass], default: true
property :user, String, default: nil
property :directory, String, default: nil
property :command, String, default: nil
property :environment, Hash, default: {}
property :service_actions, [Symbol,Array], default: :enable

default_action :nothing

load_current_value do
  if enabled
    service_actions = [:enable , :start]
  else
    service_actions = :enable
  end
end


action :create do

  include_recipe 'supervisor::default'
  r = resources(service: 'supervisor')
  r.action(:nothing)

  user new_resource.user
  command new_resource.command
  autorestart new_resource.autorestart
  autostart new_resource.autostart
  directory new_resource.directory
  environment new_resource.environment

  supervisor_service "#{service_name}" do
        command new_resource.command
        action service_actions
        user new_resource.user
        autorestart new_resource.autorestart
        autostart new_resource.autostart
        directory new_resource.directory
        environment (new_resource.environment)
    end

end
