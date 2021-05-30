Write-Host "Installing NuGet"
Install-PackageProvider NuGet -Force
Import-PackageProvider NuGet -Force

Write-Host "Setting PSGallery installation policy to 'Trusted'"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Installing SQL Server Module"
Install-Module -Name SqlServer -RequiredVersion 21.1.18245 -AllowClobber

Write-Host "Installing DSC resources"
Install-Module -Name cNtfsAccessControl -RequiredVersion 1.3.0 -Force -Confirm:$false
Install-Module -Name xNetworking -RequiredVersion 2.11.0.0 -Force -Confirm:$false
Install-Module -Name xPSDesiredStateConfiguration -RequiredVersion 4.0.0.0 -Force -Confirm:$false
Install-Module -Name xSQLServer -RequiredVersion 9.1.0.0 -Force -Confirm:$false
Install-Module -Name xWebAdministration -RequiredVersion 1.13.0.0 -Force -Confirm:$false
