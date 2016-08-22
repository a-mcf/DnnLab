# DNNLab
A vagrant / DSC configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be specified 
by editing the dsc\DNNLabConfiguration.psd1 file. The default configuration deploys both a 7.4.2 and a 8.0.3 instnace.

## Usage:
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.vagrantup.com/downloads.html)
3. Install the Vagrant DSC plugin
```
vagrant plugin install vagrant-dsc
```
4. Download or clone the repository
```
git clone http://github.com/a-mcf/DNNLab
```
5. From the repository folder, run:
```
vagrant up
```

Community Repositories:
(reference / link here)

### Todo:
- Pester tests. For now, integration only. Should run after system provisioning.
- AppVeyor support?
- Start work on automating DNN internals / settings.
- Add DNN portal support. Currently IIS configuration is supported, but DNN is not modified.
- Consider switching to a build with SQL Express built in?
- Consider adding a shortcut to http://localhost to the vagrant user's desktop.