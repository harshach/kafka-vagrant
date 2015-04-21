# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'uri'
# Configuration

KAFKA_BOX_TYPE = "hashicorp/precise64"
# end Configuration
KAFKA_BROKER_COUNT = 3
KAFKA_DISTRO_FILE = "kafka_2.10-0.8.2.1"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = KAFKA_BOX_TYPE

  config.vm.define "zookeeper" do |node|
    ip = "192.168.202.3"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "zookeeper"
    node.vm.provision "shell", inline: "apt-get update"
    node.vm.provision "shell", path: "bind/install-bind.sh"
    node.vm.provision "shell", path: "kerberos/install-kdc.sh"
    node.vm.provision "shell", path: "zookeeper/install-zookeeper.sh"
    node.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "1024"
      #v.vmx["numvcpus"] = "2"
    end
  end

  (1..KAFKA_BROKER_COUNT).each do |n|
    config.vm.define "kafka#{n}" do |node|
      ip = "192.168.202.#{3 + n}"
      node.vm.network "private_network", ip: ip
      node.vm.hostname = "kafka#{n}"
      node.vm.provision "shell", inline: "apt-get update"
      node.vm.provision "shell", path: "install-kafka.sh", args: [KAFKA_DISTRO_FILE, "localhost", "kafka#{n}.witzend.com", "kafka#{n}", "#{n}"]
      node.vm.provision "shell", path: "config-supervisord.sh", args: "kafka"
      node.vm.provision "shell", path: "start-supervisord.sh"
    end
  end

  # on virutalbox /vagrant/keytabs doesn't have permissions for the respective users
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=664"]
  config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
