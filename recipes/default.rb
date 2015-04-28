#
# Cookbook Name:: ghost
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'debian','ubuntu'
    include_recipe 'ghost-blog::ubuntu'
when 'centos'
    include_recipe 'ghost-blog::centos'
end

service 'nginx' do
    supports :start => true, :stop => true, :restart => true, :status => true
    action   :nothing
end

service 'ghost' do
    supports :start => true, :stop => true, :restart => true, :status => true
    action :nothing
end
