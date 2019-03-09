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
    mdb.vm.network "forwarded_port", guest: 80, host: 8080 
    mdb.vm.network "private_network", ip: "192.168.56.110"
    mdb.vm.provision "shell", path: 'ScenarioDB.sh'
   end
    
   config.vm.define "webk" do |webk|
    webk.vm.box = "centos/7"
    webk.vm.network "forwarded_port", guest: 80, host: 8081 
    webk.vm.network "private_network", ip: "192.168.56.111"
    webk.vm.provision "shell", path: 'ScenarioWEB_K.sh'
   end

   config.vm.define "webs" do |webs|
    webs.vm.box = "centos/7"
    webs.vm.network "forwarded_port", guest: 80, host: 8082 
    webs.vm.network "private_network", ip: "192.168.56.112"
    webs.vm.provision "shell", path: 'ScenarioWEB_S.sh'
   end
  
   config.vm.define "hapro" do |hapro|
    hapro.vm.box = "centos/7"
    hapro.vm.network "forwarded_port", guest: 80, host: 8083 
    hapro.vm.network "private_network", ip: "192.168.56.113"
    hapro.vm.provision "shell", path: 'ScenarioHAPr.sh'
   end
 




 
 
 
 end



