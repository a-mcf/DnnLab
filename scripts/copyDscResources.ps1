Write-Host "Copy composite DSC resources into the system modules path."
$compositeModules = Get-ChildItem -Path ..\dsc\modules
$compositeModules | Copy-Item -Destination "C:\Program Files\WindowsPowerShell\Modules\" -Recurse -Force