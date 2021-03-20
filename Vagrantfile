# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
    vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc5", "allow-all"]
    vb.cpus = 2
  end
  config.vm.define "router" do |router|
    router.vm.box = "ubuntu/bionic64"
    router.vm.hostname = "router"
    router.vm.network "private_network", virtualbox__intnet: "broadcast_router-client", auto_config: false
    router.vm.network "private_network", virtualbox__intnet: "broadcast_router-web-server", auto_config: false
    router.vm.provision "shell", path: "router.sh"
    router.vm.provider "virtualbox" do |vb|
      vb.memory = 256
    end
  end
  config.vm.define "client" do |client|
    client.vm.box = "ubuntu/bionic64"
    client.vm.hostname = "client"
    client.vm.network "private_network", virtualbox__intnet: "broadcast_router-client", auto_config: false
    client.vm.provision "shell", path: "client.sh"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
    end
  end
  config.vm.define "web-server" do |webserver|
    webserver.vm.box = "ubuntu/bionic64"
    webserver.vm.hostname = "web-server"
    webserver.vm.network "private_network", virtualbox__intnet: "broadcast_router-web-server", auto_config: false
    webserver.vm.provision "shell", path: "web-server.sh"
    webserver.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
    end
  end
end
