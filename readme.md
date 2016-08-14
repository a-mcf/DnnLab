# DNNLab
A vagrant configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be speceified 
by editing the dsc\DNNLabConfiguration.psd1 file. The default configuration deploys both a DNN 7.4.2 and DNN 8.0.3 instnace.

## Usage:
1. Install VirtualBox
2. Install Vagrant
3. Download or clone the repository
4. Install the Vagrant DSC provisioner
```vagrant plugin install vagrant-ds```
5. From the repository folder, run:
```vagrant up```

### Todo:
- Create a page for the default website that lists all added host headers so that the default site does something.
- Parameter validation of script resources
- Pester tests. For now, integration only. Should run after system provisioning.
- Consider moving the required DSC modules locally, and copying them into the filesystem.
- Start work on automating DNN internals / settings.