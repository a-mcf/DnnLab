Configuration DnnWebserverRoles 
{
    param(
        [ValidateSet("Present","Absent")]
        [String]
        $Ensure
    )

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    WindowsFeature IIS
    {
        Name = "Web-WebServer"
        Ensure = "Present"
    }
    
    WindowsFeature WebMgmntSvc
    {
        Name = 'Web-Mgmt-Service'
        Ensure = 'Present' 
    }

    WindowsFeature WebmgmntConsole
    {
        Name = 'Web-Mgmt-Console'
        Ensure = 'Present'
    }

    WindowsFeature WebAspNet45
    {
        Name = 'Web-Asp-Net45'
        Ensure = 'Present'
    }

    WindowsFeature WebHttpLogging
    {
        Name = 'Web-Http-Logging'
        Ensure = 'Present'
    }

    WindowsFeature WebStaticContent
    {
        Name = 'Web-Static-Content'
        Ensure = 'Present'
    }

    #WindowsFeature NetFrame35
    #{
    #    Name = 'Net-Framework-Core'
    #    Ensure = 'Present'
    #}
}