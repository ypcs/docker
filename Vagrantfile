# -*- mode: ruby -*-
# vi: set ft=ruby :

if ENV['APT_PROXY']
    APT_PROXY = ENV['APT_PROXY']
else
    APT_PROXY = ""
end

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install -y \
        apt-cacher-ng \
        debootstrap \
        make \
        qemu-utils \
        rsync \
        vagrant-libvirt
  SHELL
end
