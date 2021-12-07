#!/usr/bin/bash
sudo apt-get update
sudo apt-get install default-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
wget 'https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.55/bin/apache-tomcat-9.0.55.tar.gz'
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9.0.55.tar.gz -C /opt/tomcat --strip-components=1
#x=$(sudo update-java-alternatives -l)
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
mv tomcat.service /etc/systemd/system
sudo nano /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat


