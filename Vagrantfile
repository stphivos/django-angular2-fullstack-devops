# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo "##### PROVISIONING #####"
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: $script
  config.vm.network "private_network", ip: "10.10.10.10"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.synced_folder ".", "/home/vagrant/fullstack"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
end

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
  config.vm.host_name = "fullstack"
  config.vm.provision :shell, :path => "vagrant/bootstrap.sh"
  config.vm.forward_port 5432, 15432
end
