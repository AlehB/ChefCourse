#
# Cookbook Name:: jboss
# Recipe:: Deploy Sample Application 
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

jboss_home = node['jboss7']['jboss_home']
jboss_user = node['jboss7']['jboss_user']

remote_file "#{jboss_home}/testweb.zip" do
  source "http://www.cumulogic.com/download/Apps/testweb.zip"
  owner "root"
  group "root"
  mode "0644"
end

execute "unzip-testweb.zip" do
	cwd node['jboss7']['jboss_home']
	command "unzip testweb.zip; cp testweb #{jboss_home}/jboss-as-7.1.1.Final/standalone/deployments"; 
end

service "jbossas7" do
  action :stop
end

service "jbossas7" do
  action :start
end