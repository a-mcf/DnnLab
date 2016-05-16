# reboot required, so move to image
#Write-Host "Installing WMF 5.0 RTM"
#cinst powershell -y

Write-Host "Installing SQL Express 2008 R2"
#cinst sqlserver2008r2express-engine -y

# this has a .net 3.5 dependency.
cinst sqlserver2008r2express-managementstudio -y
#$sqlInstallArgs = ' /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD=''vagrant'' /BROWSERSVCSTARTUPTYPE=Automatic /SQLSVCSTARTUPTYPE=Automatic /SQLSVCACCOUNT=''NT AUTHORITY\Network Service'' /SQLSYSADMINACCOUNTS=''BUILTIN\ADMINISTRATORS'' /AGTSVCACCOUNT=''NT AUTHORITY\Network Service'''
$sqlInstallArgs = ' /ConfigurationFile=c:\vagrant\sqlconfig.ini'
choco install --force sqlserver2008r2express-engine -installargs $sqlInstallArgs -y