#!/bin/bash

sudo apt update -y
sudo apt-get install git -y
sudo apt-get install gcc -y
sudo apt-get install build-essential -y
sudo apt-get install libcurl4-gnutls-dev -y
sudo apt-get install libfreeimage-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install libpq-dev -y
sudo apt-get install libmysqlclient-dev -y

chmod +x hbmshell
sudo touch /etc/profile.d/hbmshell.sh
sudo chown gitpod.gitpod /etc/profile.d/hbmshell.sh
sudo echo "export PATH=/workspace/core/bin/linux:$PATH" > /etc/profile.d/hbmshell.sh
sudo chmod +x /etc/profile.d/hbmshell.sh
sudo . /etc/profile.d/hbmshell.sh