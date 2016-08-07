# DNNLab

A vagrant configuration to build a local DotNetNuke lab. Multiple versions of multiple instances can be speceified 
by editing the dsc\DNNLabConfiguration.psd1 file.

## Todo:
- Parameter validation of script resources
- Support multiple bindings per website / set the hosts file.
- Pester tests. For now, integration only. Should run after system provisioning.
- Figure out how to make SQL express install so that the hosts file entry actually works.
- Cosider moving the required modules locally, and copying them into the filesystem.
- Consider moving chocolatey installs to a script resource (CChoco doesn't support the SQL install file)