#
# Cookbook:: deploy_mongoDB
# Recipe:: default
# Created_by:: Dpurkey
# Date: 14March2018 - Happy Pi day!
# This recipe performs the following:
#	- creates a local yum repo that points to an online repo for the mongodb installation binaries
#	- installs the mongodb application 
#	- starts the mongo service (mongod)
#	- marks the mongo service to start after boot / reboot (enable)
#
#
#	This recipe was built and tested using chef-client running in the local-mode on a CentOS 7 VM
#	The VM was created (and run) under vSphere Fusion version 7 and based on 
#	the CentOS-7-x86_64-DVD-1708.iso file downloaded from CentOS
#	
#	see README.md for additional details
#
# Copyright:: 2018, The Authors, All Rights Reserved.

file '/etc/yum.repos.d/mongodb-org.repo' do
content '[mongodb-org]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1'
end

package 'mongodb-org'

service 'mongod' do
 action [:enable, :start]
end