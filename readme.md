# DNNLab

A vagrant configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be speceified 
by editing the dsc\DNNLabConfiguration.psd1 file.

## Todo:
- Parameter validation of script resources
- Support multiple bindings per website / set the hosts file.
- Pester tests. For now, integration only. Should run after system provisioning.
- Cosider moving the required DSC modules locally, and copying them into the filesystem.
- Consider moving chocolatey installs to a script resource (cChoco doesn't support the SQL install file)