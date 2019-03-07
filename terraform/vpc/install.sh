#!/bin/sh
yum install -y httpd
systemctl start httpd
chkonfig httpd on
echo "<html><h1>   Hello from RATHORE </h2></html>" > /var/www/html/index.html
