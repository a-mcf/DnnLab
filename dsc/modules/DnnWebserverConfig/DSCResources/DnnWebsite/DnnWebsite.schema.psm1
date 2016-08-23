Configuration DnnWebsite
{
    param(
        [Parameter(Mandatory=$true)]
        $Name,
        
        [Parameter(Mandatory=$true)]
        $Path,

        [Parameter(Mandatory=$true)]
        $HostName,

        [Parameter(Mandatory=$true)]
        [Hashtable[]]
        $PortalInfo
    )

    Import-DscResource -ModuleName xWebAdministration

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