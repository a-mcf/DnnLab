# DNNLab
Vagrant/DSC configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be specified 
by editing the dsc\DNNLabConfiguration.psd1 file. Two instances both running DNN 9.9.1.

## Quick Start:
Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Download and install [Vagrant](https://www.vagrantup.com/downloads.html)

Download or clone the repository
```
git clone https://github.com/a-mcf/DNNLab.git
```

From the repository folder, run:
```
vagrant up
```

Once provisioned, you can see a list of instances / portals created by visiting ```http://localhost``` 
from the browser inside of the VM.

## Credentials
As is customary with Vagrant builds, the username and password of the OS are:
```
username: vagrant
password: vagrant
```

The DNN installations use the default credentials:
```
username: host
password: dnnhost
```

## Vagrant Box
The environment currently uses a server 2019 image. You can find the image 
[here](https://app.vagrantup.com/StefanScherer/boxes/windows_2019).

## SQL Express
The build currently uses Microsoft SQL Express 2019.

## Hyper-V and Vagrant
This configuration should also work with Vagrant and Hyper-V. This image requires the 
use of the vagrant shared folder. When using Hyper-V, this works by mounting a share
on the host OS. This comes with a few caveats:
1. Vagrant must be run as account with administrator rights.
2. Vagrant will prompt for credentials to mount the share on the host OS.
3. Because DSC runs as SYSTEM from within the guest OS, it doesn't have access to the
vagrant shared folder. Consequently, any attempt to read or write files back to c:\vagrant as
part of the DSC run will fail, so these types of operations need to be handled outside of DSC.
Normal provisioning scripts don't suffer from this limitation and can be used to supplement DSC.

## Todo / Known Issues:
- Start work on automating DNN internals / settings.
  - Add DNN portal support. Currently IIS configuration is supported, but DNN is not modified.
  - Figure out an easy way to load modules.
- Docker Support
  - The DSC configuration is now somewhat untangled from Vagrant, so it should be possible to use this to build a docker container by running the scripts in the order prescribed by the Vagrantfile.
  
