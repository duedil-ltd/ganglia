#
# Cookbook Name:: ganglia
# Recipe:: default
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

include_recipe "ganglia::source"

template "/etc/init.d/ganglia-monitor" do
  source "gmond.init.erb"
  mode 0744
end

user "ganglia"

directory "/etc/ganglia"

ganglia_cluster = node[:ganglia][:gmond][:cluster_name]
gmond_receivers = []

search(:node, "recipes:ganglia AND ganglia_gmond_receiver:true AND ganglia_gmond_cluster_name:\"#{ganglia_cluster}\" AND chef_environment:#{node.chef_environment}").each do |node|
  gmond_receivers << node[:ipaddress]
end

gmond_receivers.each do |ip|
  log "Receiver #{ip}"
end

template "/etc/ganglia/gmond.conf" do
  source "gmond.conf.erb"
  variables(
    :cluster_name => node[:ganglia][:gmond][:cluster_name],
    :cluster_owner => node[:ganglia][:gmond][:cluster_owner],
    :node_name => node.name,
    :node_ip => node[:ipaddress],

    :mute => node[:ganglia][:gmond][:mute],
    :deaf => node[:ganglia][:gmond][:deaf],
    :user => "ganglia",

    :hosts => gmond_receivers,
    :send_port => node[:ganglia][:gmond][:send_port],
    :recv_port => node[:ganglia][:gmond][:recv_port],
    :accept_port => node[:ganglia][:gmond][:accept_port],

    :receiver => node[:ganglia][:gmond][:receiver]
  )

  owner "ganglia"

  notifies :restart, "service[ganglia-monitor]"
end

directory "/usr/lib/ganglia"

bash "install_ganglia_libs" do
  cwd node[:ganglia][:install_dir]
  not_if { File.exists?("/usr/lib/ganglia/modnet.so") }
  code <<-EOH
      cp gmond/modules/*/.libs/*.so /usr/lib/ganglia/
      chmod ug+rwx /usr/lib/ganglia/*.so
    EOH

  notifies :restart, "service[ganglia-monitor]"
end

service "ganglia-monitor" do
  pattern "gmond"
  supports :restart => true
  action [ :enable, :start ]
end
