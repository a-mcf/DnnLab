Configuration DnnWebsite
{
    param(
        $Name = 'lab-a',
        $Path = 'c:\inetpub\wwwroot\lab-a'
    )

    Import-DscResource -ModuleName xWebAdministration

    xWebSite DefaultWebSite
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
    }
    
    xWebsite DemoSite
    {
        Name = $Name
        PhysicalPath = $Path 
        State = 'Started'
        DependsOn = '[xWebsite]DefaultWebSite'
    }   
}