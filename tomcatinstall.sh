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
cd /tmp
x=$(sudo update-java-alternatives -l)
y="[Unit]\n
Description=Apache Tomcat Web Application Container\n
After=network.target\n

[Service]\n
Type=forking\n

Environment=JAVA_HOME=/usr/lib/jvm/${x}\n
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid\n
Environment=CATALINA_HOME=/opt/tomcat\n
Environment=CATALINA_BASE=/opt/tomcat\n
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'\n
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'\n
\n
ExecStart=/opt/tomcat/bin/startup.sh\n
ExecStop=/opt/tomcat/bin/shutdown.sh\n

User=tomcat\n
Group=tomcat\n
UMask=0007\n
RestartSec=10\n
Restart=always\n
\n
[Install]\n
WantedBy=multi-user.target"
echo -e ${y} > tomcat.service
sudo mv tomcat.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat


