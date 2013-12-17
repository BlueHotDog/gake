# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'lucid32'
  config.vm.box_url = 'http://files.vagrantup.com/lucid32.box'

  config.vm.network :private_network, ip: '33.33.33.66'

  config.ssh.forward_agent = true

  config.vm.provision :shell, path: 'provision/basic_packages.sh'
  config.vm.provision :shell, path: 'provision/shared/git.sh'
  config.vm.provision :shell, path: 'provision/shared/ruby.sh'
  config.vm.provision :shell, path: 'provision/shared/zsh.sh', privileged: false
  config.vm.provision :shell, path: 'provision/shared/nodejs.sh', privileged: false
  config.vm.provision :shell, path: 'provision/shared/bower.sh'
  config.vm.provision :shell, inline: "echo -e '#{File.read("#{Dir.home}/.gitconfig")}' > '/home/vagrant/.gitconfig'"
end
