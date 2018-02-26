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

    if [ -n "#{APT_PROXY}" ]
    then
        echo 'Acquire::HTTP::Proxy "#{APT_PROXY}";' >/etc/apt/apt.conf.d/99proxy
        mkdir -p /etc/apt-cacher-ng
        echo 'Proxy: #{APT_PROXY}' >/etc/apt-cacher-ng/zzz_custom.conf
        echo 'export APT_PROXY="#{APT_PROXY}"' >>/home/vagrant/.bash_profile
    fi

    apt-get update
    apt-get install -y \
        apt-cacher-ng \
        debootstrap \
        make \
        qemu-utils \
        vagrant-libvirt
  SHELL
end
