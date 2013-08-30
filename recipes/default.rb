#
# Cookbook Name:: circus
# Recipe:: default
#
# Copyright 2013, Ian Coffey <icoffey@engineyard.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'python'

node['circus']['dependencies'].each do |dep|
  package dep do
    action :install
  end
end

directory "/etc/circus"

template "/etc/circus/circus.ini" do
  mode "0644"
  source "circus.erb"
  action :create
end

# iter over list
python_pip 'circus'

python_pip 'circus-web'

template "/etc/init.d/circusd" do
  mode "0755"
  source "circus.init.erb"
end
