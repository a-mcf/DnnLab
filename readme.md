# DNNLab

A collection of scripts and PowerShell DSC code to build a DotNetNuke development environment in a virtual machine.

## Todo:
- Configure dependencies in the configuration.
- Move DNN download and install into a DSC resource.
- Support multiple bindings per website / set the hosts file.
- Make better use of the configuration file. Maybe specify options for different versions of DNN.
- Pester tests. For now, integration only. Should run after system provisioning.
- Figure out how to make SQL express install so that the hosts file entry actually works.
- Cosider moving the required modules locally, and copying them into the filesystem.

## Notes:
- Using the cChoco repo failed. It needs an installargs parameter.
- Use a script resource?