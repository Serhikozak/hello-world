# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  config.vm.box = "centos/7"

  

  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  

  # config.vm.network "public_network"

  #SHA256:3lphOzzuOBvFxjJniJLcNH0C6+O76iI8/teH9noKlTo.

  # config.vm.synced_folder "../data", "/vagrant_data"

  

  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #


   config.vm.provision "shell", path: 'main.sh'
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
