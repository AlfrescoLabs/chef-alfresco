#
# Cookbook Name:: alfresco
# Recipe:: app_server
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
include_recipe "tomcat"

chef_gem 'chef-rewind' do
  action :install
end
require 'chef/rewind'

#This block overrides the :start default action (inherited by "tomcat" recipe) into :stop
#Tomcat service :restart action is notified at the end of every war (repo,share,solr) deployment
rewind :service => "tomcat" do
  case node["platform"]
  when "centos","redhat","fedora","amazon"
    service_name "tomcat#{node["tomcat"]["base_version"]}"
    supports :restart => true, :status => true
  when "debian","ubuntu"
    service_name "tomcat#{node["tomcat"]["base_version"]}"
    supports :restart => true, :reload => false, :status => true
  when "smartos"
    service_name "tomcat"
    supports :restart => true, :reload => false, :status => true
  else
    service_name "tomcat#{node["tomcat"]["base_version"]}"
  end
  action [:enable, :stop]
  retries 4
  retry_delay 30
end