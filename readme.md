# DNNLab
A vagrant / DSC configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be specified 
by editing the dsc\DNNLabConfiguration.psd1 file. Two instances both running DNN 9.9.1

## Usage:
Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Download and install [Vagrant](https://www.vagrantup.com/downloads.html)

Download or clone the repository
```
git clone http://github.com/a-mcf/DNNLab
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

### Vagrant Box
The environment currently uses a server 2019 image. You can find the image 
[here](https://app.vagrantup.com/StefanScherer/boxes/windows_2019).

### SQL Express
The build currently uses Microsoft SQL Express 2019.

## Todo / Known Issues:
- Start work on automating DNN internals / settings.
    - Add DNN portal support. Currently IIS configuration is supported, but DNN is not modified.
    - Figure out an easy way to load modules.
- Docker Support
  - The DSC configuration is now somewhat untangled from Vagrant, so it should be possible to use this to build a docker container by running the scripts in the order prescribed by the Vagrantfile.
- Hyper-V?
  - This could theoretially work, but I had trouble with shared folders and `vagrant powershell`
  - Interesting article here to look into: https://stackoverflow.com/questions/54264439/how-to-get-shared-folders-working-with-vagrant-and-hyper-v
    
