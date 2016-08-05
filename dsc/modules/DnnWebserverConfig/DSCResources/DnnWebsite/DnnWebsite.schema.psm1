Configuration DnnWebsite
{
    param(
        $Name = 'lab-a',
        $Path = 'c:\inetpub\wwwroot\lab-a',
        $HostName
    )

    Import-DscResource -ModuleName xWebAdministration

    
    xWebSite DefaultWebSite
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
    }

    xWebAppPool "AppPool$($Name -replace '\W','')"
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
        BindingInfo = MSFT_xWebBindingInformation
                      {
                         Port = '80'
                         IPAddress = '*'
                         HostName = $HostName.ToLower()
                         Protocol = 'HTTP'
                      }
        DependsOn = '[xWebsite]DefaultWebSite'
    }   
}