error_file_cookbook = node['alfresco']['errorpages']['error_file_cookbook']
error_file_source = node['alfresco']['errorpages']['error_file_source']
error_folder = node['alfresco']['errorpages']['error_folder']

directory error_folder do
  action :create
  recursive true
end

error_codes = node['haproxy']['error_codes']
unless error_codes.nil? || error_codes.empty?
  error_codes.each do |error_code|
    template "#{error_folder}/#{error_code}.http" do
      cookbook error_file_cookbook
      source "#{error_file_source}/#{error_code}.http.erb"
    end
  end
end
