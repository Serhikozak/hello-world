# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  
  config.vm.provider "virtualbox" do |vb|
  
   vb.memory = "1024"
   end

   config.vm.define "web" do |web|
    web.vm.box = "centos/7"
    #web.vm.hostname = "WEB"
    web.vm.network "forwarded_port", guest: 80, host: 8081 
    web.vm.network "private_network", ip: "192.168.56.111"
    #web.vm.provision "shell", path: 'ScenarioWEB.sh'
   end



   config.vm.define "ans" do |ans|
    ans.vm.box = "centos/7"
    #mdb.vm.hostname = "MDB"
    ans.vm.network "forwarded_port", guest: 80, host: 8080 
    ans.vm.network "private_network", ip: "192.168.56.110"
    ans.vm.provision "shell", path: 'ans.sh'
    config.vm.provision "file", source: ".vagrant/machines/web/virtualbox/private_key", destination: "/home/vagrant/.ssh/web_key"
   end

   
 
end
