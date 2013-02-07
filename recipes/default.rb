#
# Cookbook Name:: coldfire-dev
# Recipe:: default
#
# Copyright 2012, Nathan Mische
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

# Get deployment key

deployment_key = ColdFireGit.get_deployment_key(node)


# Set up SSH wrapper

directory "#{Chef::Config['file_cache_path']}/.ssh" do
  owner "vagrant"
  mode "0700"
  action :create
end

file "#{Chef::Config['file_cache_path']}/.ssh/id_deploy" do
  action :create
  owner "vagrant"
  mode 00600
  content deployment_key
end

directory "#{Chef::Config['file_cache_path']}/.ssh" do
  owner "vagrant"
  recursive true
end

template "#{Chef::Config['file_cache_path']}/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh.erb"
  owner "vagrant"
  mode 0700
end

# Checkout ColdFire

directory "#{node['cf10']['webroot']}/coldfire" do
  mode "0777"
  owner "nobody"
  group "vagrant"
  action :create
end

git "#{node['cf10']['webroot']}/coldfire" do                            
  repository "#{node['coldfire-dev']['git']['repository']}"
  revision "#{node['coldfire-dev']['git']['revision']}"                              
  action :checkout                                     
  ssh_wrapper "#{Chef::Config['file_cache_path']}/wrap-ssh4git.sh"   
end

# Build ColdFire

template "#{node['cf10']['webroot']}/coldfire/local.properties" do
  source "local.properties.erb"
  owner "vagrant"
  mode 0777
end

execute "ant incremental-all" do
  cwd "#{node['cf10']['webroot']}/coldfire"
end

# Configure ColdFusion

coldfusion10_config "set_colfire_debugging" do
  action :bulk_set
  config ( { 
      "debugging" => { 
          "debugProperty" => [ 
              {"propertyName" => "enableDebug", "propertyValue" => true },
              {"propertyName" => "debugTemplate", "propertyValue" => "coldfire.cfm" },
              {"propertyName" => "showTimer", "propertyValue" => true}
          ],
          "ip" => [
              { "debugip" => "" } 
          ]
      }
    } )
end

# Set up database 

cookbook_file "#{Chef::Config['file_cache_path']}/create_coldfiretest_db.sql" do
  source "create_coldfiretest_db.sql"
  owner "vagrant"
  mode 0700
end

execute "create-database" do
  command "\"#{node['mysql']['mysql_bin']}\" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\" < \"#{Chef::Config['file_cache_path']}/create_coldfiretest_db.sql\""
  action :run
  not_if "\"#{node['mysql']['mysql_bin']}\" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\" -e 'show databases;' | grep coldfiretest"
end

# Configure ColdFusion data source

coldfusion10_config "datasource" do
  action :set
  property "MySQL5"
  args ({ "name" => "coldfiretest",
          "host" => "#{node['ipaddress']}",
          "database" => "coldfiretest",
          "username" => "coldfiretest",
          "password" => "coldfiretest" })
end 



