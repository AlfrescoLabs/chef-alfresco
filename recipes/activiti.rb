#remove the db.properties file, as it will be used as default if another one is not provided
file "#{node['alfresco']['home']}/activiti/webapps/activiti/WEB-INF/classes/db.properties" do
	action :delete
end
