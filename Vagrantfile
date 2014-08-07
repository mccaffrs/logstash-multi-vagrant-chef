# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define "logstash-server" do |server|

    server.vm.box = "hashicorp/precise32"
	
	server.vm.provider "virtualbox" do |v|
      v.name = "logstash-server"
    end
	
	server.vm.network "forwarded_port", guest: 80, host: 8080
	server.vm.network "forwarded_port", guest: 9200, host: 9200
	server.vm.network "forwarded_port", guest: 6379, host: 6379
	server.vm.network "forwarded_port", guest: 9292, host: 9292
	
	server.vm.network "public_network", ip: "192.168.1.200"
	
	server.vm.provision "chef_solo" do |chef|
	
	  chef.cookbooks_path = ['cookbooks']
	
	  chef.add_recipe "logstash-server"
	  
	end
	
  end

  config.vm.define "logstash-agent" do |agent|

    agent.vm.box = "hashicorp/precise32"
	
	agent.vm.provider "virtualbox" do |v|
      v.name = "logstash-agent"
    end
	
	agent.vm.network "forwarded_port", guest: 80, host: 8081
	agent.vm.network "forwarded_port", guest: 9200, host: 9201
	agent.vm.network "forwarded_port", guest: 6379, host: 6380
	agent.vm.network "forwarded_port", guest: 9292, host: 9293
	
	agent.vm.network "public_network", ip: "192.168.1.201"

	agent.vm.provision "chef_solo" do |chef|
	
	  chef.cookbooks_path = ['cookbooks']
	
	  chef.add_recipe "logstash-agent"
	  
	end
	
  end
  
end
