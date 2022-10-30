#! /bin/bash

echo "Welcome to the Tomcat installation setup!"
sleep 2

if [ "$EUID" -ne 0 ]
    then echo "Okay, continuing with sudo."
    USER="sudo"
else
    apt install sudo -y
fi


echo "Installing Java..."
sudo apt update && sudo apt upgrade -y
sudo apt install default-jdk -y

echo "Creatign a Tomcat user..."
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat -y

echo "Installing Tomcat..."
cd 
cd /temp 
sudo apt install curl -y

curl -O http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.11/bin/apache-tomcat-9.0.11.tar.gz -y
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1

echo "Updating permissions..."
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chwon -R tomcat webapps/ work/ temp/ logs/

echo "Creating a systemd service file..."
sudo update-java-alternatives -l
sed -i -e 8c"Environment=JAVA_HOME=$JAVA_HOME" etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat

echo "Adjusting the firewall..."
sudo ufw allow 8080

echo "Enabling Tomcat..."
sudo systemctl enable tomcat
