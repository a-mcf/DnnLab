Write-Host "Installing SQL Express 2008 R2"
$sqlInstallArgs = ' /ConfigurationFile=c:\vagrant\sqlconfig.ini'
choco install sqlserver2008r2express-engine -installargs $sqlInstallArgs -y

# this has a .net 3.5 dependency.
cinst sqlserver2008r2express-managementstudio -y

# DSC modules
Write-Host "Installing DSC Modules"
Write-Host "Setting gallery as trusted"
Set-PackageSource -Name PSGallery -Trusted -ForceBootstrap
Write-Host "Installing module"
Install-Module -Name xWebadministration
Install-Module -Name cNtfsAccessControl
Install-Module -Name xSQLServer

# dnn stuff
if (!(Test-Path 'c:\vagrant\dnn\')) { mkdir 'c:\vagrant\dnn\' | Out-Null }
$dlUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1493875&FileTime=130885394216030000&Build=21031'
(New-Object System.Net.WebClient).DownloadFile($dlUrl,"c:\vagrant\dnn\dnnInstall.zip")