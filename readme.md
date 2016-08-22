# DNNLab
A vagrant / DSC configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be specified 
by editing the dsc\DNNLabConfiguration.psd1 file. The default configuration deploys both a 7.4.2 and a 8.0.3 instnace.

## Usage:
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.vagrantup.com/downloads.html)
3. Install the Vagrant DSC plugin
```vagrant plugin install vagrant-dsc```
4. Download or clone the repository
```git clone http://github.com/a-mcf/DNNLab```
5. From the repository folder, run:
```vagrant up```

## External Dependencies
The following external dependencies are called during deployment.
### PowerShell Gallery
(reference / links here)
### Chocolatey
(links to packages here)
### Features on Demand
The build uses a minimal image, so server roles such as IIS and .Net 3.5 have to be
downloaded and installed when called by DSC. This burns time when you first ```vagrant up```
but saves time on the initial download.

## Todo / Known Issues:
- Add Pester tests. For now, integration only. Should run after system provisioning.
- AppVeyor support?
- Start work on automating DNN internals / settings.
    - Add DNN portal support. Currently IIS configuration is supported, but DNN is not modified.
    - Figure out an easy way to load modules.
- Consider switching to a build with SQL Express built in?
- Consider adding a shortcut to http://localhost to the vagrant user's desktop.