#
# Cookbook:: deploy_tomcat
# Recipe:: default
# Created_by:: Dpurkey
# Date: 14March2018 - Happy Pi day!
# This recipe performs the following:
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
#	This recipe was built and tested using chef-client running in the local-mode on a CentOS 7 VM
#	The VM was created (and run) under vSphere Fusion version 7 and based on 
#	the CentOS-7-x86_64-DVD-1708.iso file downloaded from CentOS
#
#	see README.md for additional details
#
#
# Copyright:: 2018, The Authors, All Rights Reserved.


package 'java-1.7.0-openjdk-devel'

bash 'create_dir_group_user' do
  code <<-EOH
	mkdir -p /opt/tomcat
	groupadd tomcat || true
	useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat || true
  EOH
end

bash 'extract_tomcat' do
 cwd '/var/tmp/'
  code <<-EOH
   # mkdir -p tomcat
    wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz
    tar -xzf apache-tomcat-8.5.29.tar.gz -C /opt/tomcat --strip-components=1
    rm apache-tomcat-8.5.29.tar.gz
  EOH
end

bash 'update_permissions' do
 code <<-EOH
 	chgrp -R tomcat /opt/tomcat
	cd /opt/tomcat
 	chmod -R g+r conf
 	chmod g+x conf
 	chown -R tomcat webapps/ work/ temp/ logs/
 EOH
end

file '/etc/systemd/system/tomcat.service' do
content '# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment=\'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC\'
Environment=\'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom\'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target'

end

bash 'reload_start_enable' do
code <<-EOH
	systemctl daemon-reload
	systemctl start tomcat
	systemctl enable tomcat
EOH
end

