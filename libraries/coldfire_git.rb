# Cookbook Name:: coldfire-dev
# Library:: coldfire_git
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

class Chef::Recipe::ColdFireGit 

    def self.get_deployment_key(node)

       begin
          if Chef::Config[:solo]
            begin 
              deployment_keys_data_bag = Chef::DataBagItem.load("deployment_keys","coldfire")
              deployment_key = deployment_keys_data_bag['deployment_key']
            rescue
              Chef::Log.info("No deployment_keys data bag found")
            end
          else
            begin 
              deployment_keys_data_bag = Chef::EncryptedDataBagItem.load("deployment_keys","coldfire")
              deployment_key = deployment_keys_data_bag['deployment_key']
            rescue
              Chef::Log.info("No deployment_keys encrypted data bag found")
            end
          end
        ensure    
          deployment_key ||= node['coldfire-dev']['git']['deployment_key']
        end

        deployment_key
        
    end

end