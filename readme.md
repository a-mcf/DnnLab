# DNNLab

A collection of scripts and PowerShell DSC code to build a DotNetNuke development environment in a virtual machine.


## Todo:
- Move DNN download and install into a DSC resource.
- Move download and install of chocolately packages into the DSC resource.
- Support multiple bindings per website / set the hosts file.
- Support the install of multiple DNN instances.
- Make better use of the configuration file. Maybe specify options for different versions of DNN.
- Pester tests. For now, integration only.
- Figure out how to make SQL express install so that the hosts file entry actually works.