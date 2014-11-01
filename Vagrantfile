# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.box = "precise64"

  config.vm.provision :puppet do |puppet|
      #puppet.module_path = ["modules", "extmodules"]
      puppet.module_path = ["modules"]
      puppet.options = ["--verbose", "--debug"]
  end

  #config.vm.network "forwarded_port", guest: 8000, host: 8000
  #config.vm.network "forwarded_port", guest: 80, host: 4080
  #config.vm.network "forwarded_port", guest: 25, host: 2525


end
