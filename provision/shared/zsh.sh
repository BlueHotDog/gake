#!/usr/bin/env bash

sudo apt-get -y install zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
cp /vagrant/provision/shared/.zshrc /home/vagrant/.zshrc
touch /home/vagrant/.alias
sudo chsh -s $(which zsh) vagrant
