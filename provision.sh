#!/bin/bash

# Exit with error status on any failed command
set -e

# Print command name to stdout in addition to command output
set -x

# Upgrade packages
sudo yum update -y

# Install Apache 2.4
sudo yum install -y httpd24

# Write our index.html to the apache html directory
cat << EOF | sudo tee /var/www/html/index.html
<!doctype html>
<html>
<head>
  <charset utf-8>
  <title>AWS on Tap AMI Demo</title>
</head>
<body>
  <h1>Cheers, AWS on Tap Members!</h1>
</body>
</html>
EOF

# Start apache
sudo service httpd start

# Enable apache
sudo chkconfig httpd on
