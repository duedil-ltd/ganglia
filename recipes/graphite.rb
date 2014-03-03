#
# Cookbook Name:: ganglia
# Recipe:: graphite
#
# Copyright 2011, Heavy Water Software Inc.
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

graphite_host = search(:node, "role:#{node[:ganglia][:graphite][:chef_role]} AND chef_environment:#{node[:ganglia][:graphite][:environment]}").map {|node| node[:ipaddress]}
if graphite_host.empty?
  graphite_host = ["localhost"]
end

template "/usr/local/sbin/ganglia_graphite.rb" do
  source "ganglia_graphite.rb.erb"
  mode "744"
  variables({
    :graphite_host => graphite_host.first,
    :ganglia_port => node[:ganglia][:gmond][:accept_port],
    :grid => node[:ganglia][:grid_name]
  })
end

cron "ganglia_graphite" do
  command "/usr/local/sbin/ganglia_graphite.rb"
end
