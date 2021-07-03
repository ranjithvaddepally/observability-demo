#!/bin/bash

####### Logs ####

cloud_id='observability-deployment:dXMtd2VzdDEuZ2NwLmNsb3VkLmVzLmlvJDYyNmMyYzlhMTEzOTRlZjI4ZDU0Y2M3NjU2YTM3YjQxJDg5ZTI1ZGRjYmU2NDQ0ODU5YzgxNjQ1ZTY2OTRhNGJi'
credentials='elastic:vdsA5aKqyqcBkCSlQSdeybcL'

sudo yum install epel-release -y

sudo yum install nginx -y

sudo service nginx start

sudo mkdir /opt/demo

sudo chown root:vagrant /opt/demo
sudo chmod 775 /opt/demo


cd /opt/demo
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.11.2-linux-x86_64.tar.gz
tar xzvf filebeat-7.11.2-linux-x86_64.tar.gz
sudo chown -R root filebeat-7.11.2-linux-x86_64
cd filebeat-7.11.2-linux-x86_64



#cat  <<ENDSSH >> filebeat.yml 2>&1
#cloud.id: "$cloud_id"
#cloud.auth: "$credentials"
#ENDSSH


echo 'cloud.id: '\"$cloud_id\"'
cloud.auth: '\"$credentials\"'' | sudo tee -a filebeat.yml




sudo ./filebeat modules list

sudo ./filebeat modules enable system nginx mysql




#echo '- module: nginx
#  access:
#    var.paths: ["/var/log/nginx/access.log*"]' > modules.d/nginx.yml
    
echo '- module: nginx
  access:
    var.paths: ["/var/log/nginx/access.log*"]' | sudo tee modules.d/nginx.yml    

sudo ./filebeat setup -e

#nohup sudo ./filebeat -e 1> output.txt 2>&1 < /dev/null &



#sudo sh -c 'nohup dotnet application.dll > out.log 2>&1 &'

sudo bash -c 'nohup ./filebeat -e 1> logs/output.txt 2>&1 < /dev/null &'