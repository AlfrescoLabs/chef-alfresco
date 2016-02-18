#remove the db.properties file, as it will be used as default if another one is not provided
# done only in the community edition

file "#{node['alfresco']['home']}/activiti/webapps/activiti-app/WEB-INF/classes/db.properties" do
	action :delete
	only_if { node['activiti-app']['edition'] == "community" }
end