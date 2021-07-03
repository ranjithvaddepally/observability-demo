#!/bin/bash

####### metricbeat ####

cloud_id='observability-deployment:dXMtd2VzdDEuZ2NwLmNsb3VkLmVzLmlvJDYyNmMyYzlhMTEzOTRlZjI4ZDU0Y2M3NjU2YTM3YjQxJDg5ZTI1ZGRjYmU2NDQ0ODU5YzgxNjQ1ZTY2OTRhNGJi'
credentials='elastic:vdsA5aKqyqcBkCSlQSdeybcL'


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
