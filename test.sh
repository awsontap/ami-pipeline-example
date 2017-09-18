#!/bin/bash

# Exit with error status on any failed command
# If any command fails, packer will recognize the error and fail the AMI build.
set -e

# Print command name to stdout in addition to command output
set -x

# Verify that apache service is enabled so it will start after a reboot
sudo chkconfig --list httpd | grep '5:on'

# Verify that our website is up and running
curl localhost 2>/dev/null | grep 'AWS on Tap'
