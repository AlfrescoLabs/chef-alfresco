#remove the db.properties file, as it will be used as default if another one is not provided

if node['activiti-app']['edition'] == "community"
	file "#{node['alfresco']['home']}/activiti-app/webapps/activiti-app/WEB-INF/classes/db.properties" do
		action :delete
	end
end
