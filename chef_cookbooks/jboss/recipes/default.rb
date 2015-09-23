#
# Cookbook Name:: jboss
# Recipe:: Install JBoss
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

jboss_home = node['jboss7']['jboss_home']
jboss_user = node['jboss7']['jboss_user']

user jboss_user do
	action :create
	comment "jboss User"
	home "/home/#{jboss_user}"
	shell "/bin/bash"
	supports :manage_home => true 
end

cookbook_file "#{jboss_home}/jboss-as-7.1.1.Final.tar.gz" do
  source "jboss-as-7.1.1.Final.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

=begin

По хорошему тут через remote:

remote_file "#{jboss_home}/jboss-as-7.1.1.Final.tar.gz" do
  source "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

=end

directory "#{jboss_home}/jbossas7" do
	owner jboss_user
	group jboss_user
	mode "0755"
	recursive true
end

execute 'untar-jboss' do
  cwd node['jboss7']['jboss_home']
  command "tar -xzf jboss-as-7.1.1.Final.tar.gz;chown -R #{jboss_user}.#{jboss_user} jbossas7"
  not_if { File.exists?("/file/contained/in/tar/here") }
end

cookbook_file '/etc/init.d/jbossas7' do
  source 'jbossas7'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'scriptexectuable' do
    command "chmod +x /etc/rc.d/init.d/jbossas7"
end



