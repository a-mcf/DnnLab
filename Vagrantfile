# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "a-mcf/Win2012R2-WMF5-Min"
  
  config.vm.provision "shell", path: "./scripts/bootstrap.ps1"
  
  # Run DSC
  config.vm.provision "dsc", run: "always" do |dsc|

    # Set of module paths relative to the Vagrantfile dir.
    #
    # These paths are added to the DSC Configuration running
    # environment to enable local modules to be addressed.
    #
    # @return [Array] Set of relative module paths.
    dsc.module_path = ["dsc/modules"]

    # The path relative to `dsc.manifests_path` pointing to the Configuration file
    dsc.configuration_file  = "DNNLabConfig.ps1"

    # The path relative to Vagrantfile pointing to the Configuration Data file
    dsc.configuration_data_file  = "dsc/DNNLabConfig.psd1"

    # The Configuration Command to run. Assumed to be the same as the `dsc.configuration_file`
    # (sans extension) if not provided.
    #dsc.configuration_name = "MyWebsite"

    # Relative path to a pre-generated MOF file.
    #
    # Path is relative to the folder containing the Vagrantfile.
    # dsc.mof_path = "mof"

    # Relative path to the folder containing the root Configuration manifest file.
    # Defaults to 'manifests'.
    #
    # Path is relative to the folder containing the Vagrantfile.
    dsc.manifests_path = "dsc"

    # Commandline arguments to the Configuration run
    #
    # Set of Parameters to pass to the DSC Configuration.
    #dsc.configuration_params = {"-MachineName" => "localhost", "-WebAppPath" => "c:\\vagrant\\buildTemp\\_PublishedWebsites\\ShortUrlWebApp", "-HostName" => hostname}

    # The type of synced folders to use when sharing the data
    # required for the provisioner to work properly.
    #
    # By default this will use the default synced folder type.
    # For example, you can set this to "nfs" to use NFS synced folders.
    # dsc.synced_folder_type = ""

    # Temporary working directory on the guest machine.
    # dsc.temp_dir = "c:/tmp/vagrant-dsc"
  end
  
   config.vm.provision "shell", path: "./scripts/installdnn.ps1"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
