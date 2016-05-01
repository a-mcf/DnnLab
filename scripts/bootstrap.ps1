# reboot required, so move to image
#Write-Host "Installing WMF 5.0 RTM"
#cinst powershell -y

Write-Host "Installing SQL Express 2008 R2"
cinst sqlserver2008r2express-engine -y

# this has a .net 3.5 dependency.
cinst sqlserver2008r2express-managementstudio -y
#cinst sqlserver2012express-managementstudio