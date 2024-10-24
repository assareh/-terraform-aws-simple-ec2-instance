#!/bin/bash
yum update -y
amazon-linux-extras install -y mariadb10.5
amazon-linux-extras install -y php8.2
yum install -y httpd
systemctl start httpd
systemctl enable httpd
systemctl is-enabled httpd

usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
cd /var/www/html
curl -O https://raw.githubusercontent.com/hashicorp/learn-terramino/master/index.php