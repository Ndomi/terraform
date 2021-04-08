#!/bin/bash

### Install amazon-ssm-agent ###

cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads
windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sleep 10

 ### Installing awslogs-agent on EC2 Intsences ###

sudo yum install awslogs -y
sudo systemctl enable awslogsd.service
sudo systemctl start awslogsd.service