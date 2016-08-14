# DNNLab

A vagrant configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be speceified 
by editing the dsc\DNNLabConfiguration.psd1 file.

## Usage:
1. Install VirtualBox
2. Install Vagrant
3. Download or clone the repository
4. Install the Vagrant DSC provisioner
```vagrant plugin install vagrant-ds```
5. From the repository folder, run:
```vagrant up```

### Todo:
- Consider moving chocolatey installs to a script resource (cChoco doesn't support the SQL install file)
- Parameter validation of script resources
- Pester tests. For now, integration only. Should run after system provisioning.
- Consider moving the required DSC modules locally, and copying them into the filesystem.
- Start work on automating DNN internals / settings.