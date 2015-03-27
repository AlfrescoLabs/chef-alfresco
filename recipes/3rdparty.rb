include_recipe "build-essential::default"
include_recipe "openoffice::headless"
include_recipe "openoffice::apps"
include_recipe "imagemagick::default"

if node['platform_family'] != "rhel" and node['alfresco']['version'] < "5.0"
  include_recipe "swftools::default"
end
