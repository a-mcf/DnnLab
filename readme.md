# DNNLab
A vagrant / DSC configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be specified 
by editing the dsc\DNNLabConfiguration.psd1 file. The default configuration deploys a single instance of 7.4.2 and 8.0.4.

## Usage:
Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Download and install [Vagrant](https://www.vagrantup.com/downloads.html)

Install the Vagrant DSC plugin
```
vagrant plugin install vagrant-dsc
```

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

If you make DSC changes and want to re-run the DSC provisioner, run:
```
vagrant provision --provision-with dsc
```
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

## External Downloads

### Vagrant Box
The environment currently uses a minimal Vagrant box. You can find the image 
[here](https://atlas.hashicorp.com/a-mcf/boxes/Win2012R2-WMF5-min).

### Features on Demand
The build uses a minimal image, so server roles such as IIS and .Net 3.5 have to be
downloaded and installed when called by DSC. This burns time when you first ```vagrant up```
but saves time on the initial download. Replacing the image with a "minimal IIS" build is planned.

### SQL Express
The build currently uses Microsoft SQL Express 2008 R2. This version was selected to keep the download
small while still including SQL Server Management Studio.

## Todo / Known Issues:
- Add Pester tests. For now, integration only. Should run after system provisioning.
- Start work on automating DNN internals / settings.
    - Add DNN portal support. Currently IIS configuration is supported, but DNN is not modified.
    - Figure out an easy way to load modules.
- Add options for different versions of SQL, move install options into PSD1 file.
- Consider adding a shortcut to http://localhost to the vagrant user's desktop.
- Consider restructuring be compatible with Lability.
- Switch to using the 'high quality' WebAdministration module.
- AppVeyor support?