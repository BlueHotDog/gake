#!/usr/bin/env bash

sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs
sudo npm install -g node-inspector
sudo npm install -g grunt-cli grunt
