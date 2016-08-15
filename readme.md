# DNNLab
A vagrant configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be speceified 
by editing the dsc\DNNLabConfiguration.psd1 file. The default configuration deploys both a DNN 7.4.2 and DNN 8.0.3 instnace.

## Usage:
1. Install VirtualBox
2. Install Vagrant
3. Install the Vagrant DSC plugin

```vagrant plugin install vagrant-dsc```
4. Download or clone the repository

```git clone http://github.com/a-mcf/DNNLab```
5. From the repository folder, run:
```vagrant up```

Community Repositories:
(reference / link here)

### Todo:
- Create a page for the default website that lists all added host headers so that the default site does something.
- Pester tests. For now, integration only. Should run after system provisioning.
- AppVeyor support?
- Start work on automating DNN internals / settings.