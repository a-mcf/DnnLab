$installHtml = 'c:\users\vagrant\documents\dnninstall.html' 
$installUri = 'http://localhost/install/install.aspx?mode=install'

if (!(Test-Path $installHtml))
{
    Write-Host  "Installing DotNetNuke"
    Invoke-WebRequest -UseBasicParsing -Uri $installUri -OutFile $installHtml
    $installSuccess = Select-String -SimpleMatch "Successfully Installed Site" -Path $installHtml -Quiet
    
    if ($installSuccess)
    {
        Write-Host "Install Complete"
    }
    else 
    {
        $installFailedHtml = ("$installHtml" + "failed.htm")
        Rename-Item $installHtml $installFailedHtml
        Write-Error "Install failed. See $installFailedHtml for details."
    }
}
else 
{
    Write-Host "DotNetNuke install already attempted. Skipping"    
}
