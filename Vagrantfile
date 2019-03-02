# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
      # config.vm.network "forwarded_port", guest: 80, host: 8080

     #config.vm.network "private_network", ip: "192.168.56.110"
   #config.vm.network "private_network", ip: "192.168.56.11"

    # config.vm.synced_folder "../data", "/vagrant_data"

   config.vm.provider "virtualbox" do |vb|
    #   vb.gui = true
     vb.memory = "512"
   end
  
    #config.vm.define "dbmaria" do |dbmaria|
      dbmaria.vm.box = "centos/7"
      dbmaria.vm.network "private_network", ip: "192.168.56.110"
      dbmaria.vm.provision "shell", path: "ScenarioDB.sh"
      
    end   
    
    config.vm.define "webapache" do |webapache|
      webapache.vm.box = "centos/7"
      webapache.vm.hostname = "web1"
      webapache.vm.network "private_network", ip: "192.168.56.111"
      webapache.vm.provision "shell", path: "ScenarioWEB.sh"
    end
    
    #config.vm.define "webapa" do |webapa|
      webapa.vm.box ="centos/7"
      webapa.vm.hostname = "web2"
      webapa.vm.network "private_network", ip: "192.168.56.112"
      webapa.vm.provision "shell", path: "ScenarioWEB2.sh"
    end

    #config.vm.define "lbhap" do |lbhap|
      lbhap.vm.box = "centos/7"
      lbhap.vm.network "private_network", ip: "192.168.56.113"
      lbhap.vm.provision "shell", path: "ScenarioHAProxy.sh"
    end
  end
end