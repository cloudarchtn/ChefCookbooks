# deploy_tomcat
#
# This cookbook performs the following:
#	- install openjdk java (1.7.0)
#	- sets up tomcat directory
#	- creates tomcat user group
#	- adds tomcat user to the tomcat user group
#	- downloads and extracts the tomcat binary (version 8.5.29) into the tomcat directory
#	- remove the install tarball
#	- sets permissions on the tomcat directories
#	- creates tomcat.service file
#	- reloads the system daemon files
#	- starts tomcat
#	- marks the tomcat service to start after reboot (enable)
#
#	the recipe was built using chef-client running in the local-mode on a CentOS 7 VM
#	The VM was created (and run) under vSphere Fusion version 7 and based on 
#	the CentOS-7-x86_64-DVD-1708.iso file downloaded from CentOS
#
#	In testing this cookbook was deployed using the following command (from the cookbooks directory):
#
#	sudo chef-client --local-mode --runlist 'recipe[deploy_tomcat]'
#

