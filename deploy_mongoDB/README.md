# deploy_mongoDB

This cookbook performs the following:
#	- creates a local yum repo that points to an online repo for the mongodb installation binaries
#	- installs the mongodb application 
#	- starts the mongo service (mongod)
#	- marks the mongo service to start after boot / reboot (enable)
#
#
#	The recipe was built using chef-client running in the local-mode on a CentOS 7 VM
#	The VM was created (and run) under vSphere Fusion version 7 and based on 
#	the CentOS-7-x86_64-DVD-1708.iso file downloaded from CentOS
#
#	In testing this cookbook was deployed using the following command (from the cookbooks directory):
#	  sudo chef-client --local-mode --runlist 'recipe[deploy_mongoDB]'
#
