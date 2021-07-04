#!/bin/bash

####### metricbeat ####

cloud_id='xxxxx'
credentials='xxxx'



sudo mkdir /opt/demo

sudo chown root:vagrant /opt/demo
sudo chmod 775 /opt/demo


cd /opt/demo


curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.11.2-linux-x86_64.tar.gz
tar xzvf metricbeat-7.11.2-linux-x86_64.tar.gz
sudo chown -R root metricbeat-7.11.2-linux-x86_64
cd metricbeat-7.11.2-linux-x86_64


#cat  <<ENDSSH >> metricbeat.yml 2>&1
#cloud.id: "$cloud_id"
#cloud.auth: "$credentials"
#ENDSSH


echo 'cloud.id: '\"$cloud_id\"'
cloud.auth: '\"$credentials\"'' | sudo tee -a metricbeat.yml

sudo ./metricbeat modules list



sudo ./metricbeat modules enable apache




sudo ./metricbeat setup -e




#nohup ./metricbeat -e &

sudo bash -c 'nohup ./metricbeat -e 1> logs/output.txt 2>&1 < /dev/null &'




####### Logs ####



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