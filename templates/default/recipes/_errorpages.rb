error_file_cookbook = node['alfresco']['errorpages']['error_file_cookbook']
error_file_source = node['alfresco']['errorpages']['error_file_source']
error_folder = node['alfresco']['errorpages']['error_folder']

directory error_folder do
  action :create
  recursive true
end

%w( 400 403 404 408 500 502 503 504 ).each do |error_code|
  template "#{error_folder}/#{error_code}.http" do
    cookbook error_file_cookbook
    source "#{error_file_source}/#{error_code}.http.erb"
  end
end
