#!/bin/bash

apm_token=xxxxxx
apm_server_url=xxxxxx



sudo yum install git -y

curl -fsSL https://get.docker.com/ | sudo sh

sudo systemctl start docker

sudo systemctl status docker

sudo systemctl enable docker

sudo usermod -aG docker vagrant


sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo docker-compose --version

sudo mkdir /opt/demo

sudo chown root:vagrant /opt/demo
sudo chmod 775 /opt/demo


cd /opt/demo

git clone https://github.com/ranjithvaddepally/microservice-app-example.git



cd microservice-app-example


cat  <<ENDSSH > .env 2>&1
TOKEN=$apm_token
SERVER=$apm_server_url
ENDSSH

sudo docker-compose up --build 

