# install SQL
Write-Host "Installing SQL Express 2008 R2 / .Net Framework 3.5"
$sqlInstallArgs = ' /ConfigurationFile=c:\vagrant\sqlconfig.ini'
choco install sqlserver2008r2express-engine -installargs $sqlInstallArgs -y
choco install sqlserver2008r2express-managementstudio -y

# DSC modules
Write-Host "Setting PSGallery as trusted"
Set-PackageSource -Name PSGallery -Trusted -ForceBootstrap | Out-Null

Write-Host "Installing modules from PSGallery"
Install-Module -Name xWebadministration
Install-Module -Name cNtfsAccessControl
Install-Module -Name xSQLServer
Install-Module -Name xNetworking
Install-Module -Name cChoco
