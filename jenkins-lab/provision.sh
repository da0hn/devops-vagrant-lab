#!/usr/bin/env bash

yum install epel-release -y
yum install wget git -y
yum install java-11-openjdk-devel -y

echo "Installing docker..."

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker

echo "Installing docker compose..."

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


echo "Installing Jenkins and dependencies..."

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl restart docker

sudo usermod -aG docker jenkins
sudo yum install telnet -y
sudo yum install net-tools -y

echo "Installing Sonar Scanner..."

sudo yum install wget unzip -y
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
sudo unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
sudo mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonarqube-scanner
chown -R jenkins:jenkins /opt/sonarqube-scanner

echo 'export PATH=$PATH:/opt/sonarqube-scanner/bin' | sudo tee -a /etc/profile

curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y
