Vagrant.configure("2") do |config|
    config.vm.box = "debian/buster64"
    
    
    config.vm.define "master" do |pgr1|
      pgr1.vm.network "private_network", ip: "192.168.2.100", virtualbox__intnet: "puppetnet"
      pgr1.vm.hostname = "master"
  
      pgr1.vm.provider "virtualbox" do |p1|
          p1.name = "master"
          p1.gui = false
          p1.memory = 1512
          p1.cpus = 2
      end 

      pgr1.vm.provision "shell", path: "initial_setup.sh"
  
    end
    
    config.vm.define "client" do |pgr2|
      pgr2.vm.network "private_network", ip: "192.168.2.101", virtualbox__intnet: "puppetnet"
      pgr2.vm.hostname = "client"
  
      pgr2.vm.provider "virtualbox" do |p2|
          p2.name = "client"
          p2.gui = false
          p2.memory = 512
          p2.cpus = 1
      end 

      pgr2.vm.provision "shell", path: "initial_setup.sh"
  
    end
    
  end