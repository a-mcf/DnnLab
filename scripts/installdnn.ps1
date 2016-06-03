$installHtml = 'c:\users\vagrant\documents\dnninstall.html' 
$installUri = 'http://localhost/install/install.aspx?mode=install'
if (!(Test-Path $installHtml))
{
    Write-Host  "Installing DotNetNuke"
    Invoke-WebRequest -UseBasicParsing -Uri $installUri -OutFile $installhtml    
}
else 
{
    Write-Host "DotNetNuke install already attempted. Skipping"    
}
