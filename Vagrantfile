# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network "private_network", ip: "10.10.10.10"
  config.vm.network "forwarded_port", guest: 8000, host: 28000
  config.vm.network "forwarded_port", guest: 5432, host: 25432

  config.vm.synced_folder ".", "/home/vagrant/#{ENV['APPLICATION_NAME']}"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.ssh.forward_agent = true

  config.vm.provision "shell", path: "scripts/setup.sh"
  config.vm.provision :shell do |s|
    s.env = {
      SERVER_ROOT_NAME:ENV['SERVER_ROOT_NAME'],
      SERVER_ROOT_PATH:ENV['SERVER_ROOT_PATH'],
      APPLICATION_NAME:ENV['APPLICATION_NAME'],
      APPLICATION_PATH:ENV['APPLICATION_PATH'],
      VIRTUALENV_PATH:ENV['VIRTUALENV_PATH'],
      GIT_BRANCH:ENV['GIT_BRANCH'],
      GIT_REPO:ENV['GIT_REPO']
    }
    s.path = "scripts/vagrant.sh"
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/ansible/vagrant.yml"
    ansible.verbose = "vv"
    #ansible.install = true  # For ansible-local provisioner
    ansible.limit = "all"
    ansible.inventory_path = "provisioning/ansible/inventories/vagrant"
    ansible.extra_vars = {
        "server_root_name" => "#{ENV['SERVER_ROOT_NAME']}",
        "application_name" => "#{ENV['APPLICATION_NAME']}",
        "project_name" => "#{ENV['PROJECT_NAME']}",
        "virtualenv_path" => "#{ENV['VIRTUALENV_PATH']}",
        "project_path" => "#{ENV['PROJECT_PATH']}"
    }
  end
end
