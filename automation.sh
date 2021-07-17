#!/bin/bash

timestamp=$(date '+%d%m%Y-%H%M%S')
myname="Yashraj"
s3_bucket="upgrad-yashraj"

echo "Updating the sources.list"
sudo apt update -y

# Checking if httpd service exists
if ! systemctl --type=service | grep -q 'apache2.service'; then
	echo "Installing apache2 service"
        sudo apt install apache2 -y
	echo "Updating firewall rule to allow port 80 connection"
        sudo ufw allow 'Apache'
fi

# Checking if httpd service running
if ! systemctl --type=service --state=running | grep -q 'apache2.service'; then
	echo "Starting service apache2"
        systemctl start apache2
fi

# Checking if any dameon process of apache running
if ! ss -ltup | grep -q 'apache2'; then
	echo "Terminating if no daemon process exist"
        exit 1
fi

# Visting the apache2 directory
cd /var/log/apache2/

# Compressing the access.log and error.log to a tar file
tar -czf /tmp/"${myname}"-httpd-logs-"${timestamp}".tar access.log error.log

# Installing awscli client
sudo apt update -y && sudo apt install awscli -y

# Uploading the tar to s3 bucket hosted on aws
aws s3 \
cp /tmp/"${myname}"-httpd-logs-"${timestamp}".tar \
s3://${s3_bucket}/"${myname}"-httpd-logs-"${timestamp}".tar
