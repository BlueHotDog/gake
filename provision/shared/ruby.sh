#!/usr/bin/env bash

apt-get -y install python-software-properties
apt-add-repository ppa:brightbox/ruby-ng
apt-get update
apt-get -y install ruby rubygems ruby-switch ruby1.9.1 ruby1.9.1-dev
gem install ruby-debug-ide --pre --no-ri --no-rdoc
gem install debugger --no-ri --no-rdoc
