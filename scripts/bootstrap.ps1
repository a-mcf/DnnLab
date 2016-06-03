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

# download DNN install file if it does not exist
if (!(Test-Path -Path "c:\vagrant\dnn\dnnInstall.zip"))
{
    if (!(Test-Path 'c:\vagrant\dnn\'))
    { 
        mkdir 'c:\vagrant\dnn\' | Out-Null 
        mkdir 'c:\vagrant\dnn\install' | Out-Null
    }
    
    $dlUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1493875&FileTime=130885394216030000&Build=21031'
    Write-Host "Downloading DNN from $dlUrl"
    (New-Object System.Net.WebClient).DownloadFile($dlUrl,"c:\vagrant\dnn\dnnInstall.zip")
    Expand-Archive -Path 'c:\vagrant\dnn\dnnInstall.zip' -DestinationPath 'c:\vagrant\dnn\install\'
}