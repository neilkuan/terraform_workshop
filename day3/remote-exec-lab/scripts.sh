#!/bin/bash
sudo yum -y install httpd
sudo systemctl start httpd && sudo systemctl enable httpd
echo '<h1><center>This is our Cathay Bootcamp Website</center></h1>' > index.html
sudo mv index.html /var/www/html/