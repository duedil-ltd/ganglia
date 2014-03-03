#
# Cookbook Name:: ganglia
# Recipe:: source
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

%w{ libtool libapr1-dev libconfuse-dev libexpat1-dev librrd-dev libpcre3-dev }.each do |name|
  package name
end

git node[:ganglia][:install_dir] do
  repository node[:ganglia][:repo]
  revision node[:ganglia][:version]
  enable_submodules true

  action :checkout
  notifies :run, "bash[compile_ganglia_src]"
end

bash "compile_ganglia_src" do
  cwd node[:ganglia][:install_dir]
  creates "/usr/local/sbin/gmond"
  code <<-EOH
      ./bootstrap && ./configure --with-gmetad --sysconfdir=/etc/ganglia && make && make install
    EOH
end
