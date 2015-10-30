# -*- mode: ruby -*-
# vi: set ft=ruby :

# vm configuration
NODES = 2
MEMORY = 1024
CPUS = 2

Vagrant.configure(2) do |config|
  (1..NODES).each do |i|
    config.vm.define "docker-#{i}" do |node|
      node.vm.box = "ubuntu/vivid64"
      node.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/vivid/current/vivid-server-cloudimg-amd64-vagrant-disk1.box"
      node.vm.box_check_update = true
      node.vm.network :private_network, ip: "192.168.99.1#{i}"
      node.vm.hostname = "docker-#{i}"

      # setup vm
      node.vm.provider :virtualbox do |v|
        v.name = "docker-#{i}"
        v.memory = MEMORY
        v.cpus = CPUS
      end

      # setup ssh
      node.ssh.insert_key = false
      node.ssh.private_key_path = [ "~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key" ]
      node.vm.provision :file, source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"

      # fix sudo
      node.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      # provision docker
      node.vm.provision :docker, images: [
          "busybox:latest", "ubuntu:14.04", "ubuntu:15.04"
      ]
    end
  end
end
