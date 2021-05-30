# -*- mode: ruby -*-
# vi: set ft=ruby :

$runDscScript = <<SCRIPT
  Write-Host "Copy composite DSC resources into the system modules path."
  $compositeModules = Get-ChildItem -Path c:\\vagrant\\dsc\\modules
  $compositeModules | Copy-Item -Destination 'C:\\Program Files\\WindowsPowerShell\\Modules\\' -Recurse -Force
  
  Write-Host "Compiling the MOF"
  . c:\\vagrant\\dsc\\DNNLabConfig.ps1
  DNNLabConfig -ConfigurationData 'c:\\vagrant\\dsc\\DNNLabConfig.psd1' -OutputPath $env:TEMP
  
  Write-Host "Starting DSC configuration"
  Start-DscConfiguration -Force -Wait -Verbose -Path $env:TEMP
SCRIPT

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
  config.vm.provision "shell", inline: $runDscScript, run: "always"
end
