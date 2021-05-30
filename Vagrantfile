# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.box = "StefanScherer/windows_2019"
  
  # virtualbox settings
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # hyper-v settings
  config.vm.provider "hyperv" do |h|
    h.enable_virtualization_extensions = true
    h.linked_clone = true
  end

  # install modules/resources and other prequisites
  config.vm.provision "shell", path: "./scripts/Bootstrap.ps1"
  
  # Run DSC
  config.vm.provision "shell", path: "./scripts/vagrantInvokeDscScript.ps1", run: "always"
end
