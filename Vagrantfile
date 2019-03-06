# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
   # config.vm.provider "virtualbox" do |vb|
    #   vb.gui = true
    #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end    
   
   
   config.vm.define "mdb" do |mdb|
    mdb.vm.box = "centos/7"
    mdb.vm.hostname = "MDB"
    mdb.vm.network "forwarded_port", guest: 80, host: 8080 
    mdb.vm.network "private_network", ip: "192.168.56.110"
    mdb.vm.provision "shell", path: 'ScenarioDB.sh'
   end

   config.vm.define "web" do |web|
    web.vm.box = "centos/7"
    web.vm.hostname = "WEB"
    web.vm.network "forwarded_port", guest: 80, host: 8081 
    web.vm.network "private_network", ip: "192.168.56.111"
    web.vm.provision "shell", path: 'ScenarioWEB.sh'
   end
  
end



