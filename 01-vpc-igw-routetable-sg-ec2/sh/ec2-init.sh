#!/bin/bash

# using elevated privileges, update the yum package manager and install MySQL and Redis
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install -y mysql redis