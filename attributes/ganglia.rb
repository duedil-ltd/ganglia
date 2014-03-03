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

default[:ganglia][:version] = "3.3.7"
default[:ganglia][:repo] = "https://github.com/ganglia/monitor-core.git"
default[:ganglia][:install_dir] = "/var/lib/ganglia"

default[:ganglia][:grid_name] = "unspecified"

default[:ganglia][:gmond][:cluster_name] = "unspecified"
default[:ganglia][:gmond][:cluster_owner] = "unspecified"
default[:ganglia][:gmond][:receiver] = false
default[:ganglia][:gmond][:recv_port] = 8649
default[:ganglia][:gmond][:accept_port] = 8649
default[:ganglia][:gmond][:mute] = false
default[:ganglia][:gmond][:deaf] = false

default[:ganglia][:graphite][:chef_role] = nil
default[:ganglia][:graphite][:environment] = nil
