#
# Cookbook Name:: alfresco
# Recipe:: nginx_proxy_conf
#
# Copyright 2011, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['alfresco']['nginx']['proxy'] && node['alfresco']['nginx']['proxy'] == "enable"
  include_recipe "nginx::source"

  if node['alfresco']['nginx']['www_redirect'] &&
      node['alfresco']['nginx']['www_redirect'] == "disable"
    www_redirect = false
  else
    www_redirect = true
  end

  template "#{node['nginx']['dir']}/sites-available/alfresco.conf" do
    source      "nginx_alfresco.conf.erb"
    owner       'root'
    group       'root'
    mode        '0644'
    variables(
      :host_name        => node['alfresco']['nginx']['host_name'],
      :host_aliases     => node['alfresco']['nginx']['host_aliases'],
      :listen_ports     => node['alfresco']['nginx']['listen_ports'],
      :www_redirect     => www_redirect,
      :max_upload_size  => node['alfresco']['nginx']['client_max_body_size']
    )

    if File.exists?("#{node['nginx']['dir']}/sites-enabled/alfresco.conf")
      notifies  :restart, 'service[nginx]'
    end
  end

  nginx_site "alfresco.conf" do
    if node['alfresco']['nginx_proxy'] &&
        node['alfresco']['nginx_proxy'] == "disable"
      enable false
    else
      enable true
    end
  end
end
