Configuration DnnWebsite
{
    param(
        $Name = 'lab-a',
        $Path = 'c:\inetpub\wwwroot\lab-a',
        $HostName,
        [Hashtable[]] $PortalInfo
    )

    Import-DscResource -ModuleName xWebAdministration

    
    xWebSite DefaultWebSite
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
    }

    $xWebAppPool = "AppPool$($Name -replace '\W','')"
    xWebAppPool $xWebAppPool
    {
        Name = $Name
        Ensure = 'Present'
    }

    xWebsite DemoSite
    {
        Name = $Name
        PhysicalPath = $Path 
        State = 'Started'
        ApplicationPool = $Name
        BindingInfo = $PortalInfo.Foreach({
            MSFT_xWebBindingInformation
            {
                Port = $_.Port
                IPAddress = $_.IPAddress
                HostName = $_.HostName
                Protocol = $_.Protocol
            }
        })
        DependsOn = '[xWebsite]DefaultWebSite',"[xWebAppPool]$xWebAppPool"
    }   
}