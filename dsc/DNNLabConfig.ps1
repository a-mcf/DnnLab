Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'xWebAdministration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xSQLServer'
    
    file DemoFile
    {
        ensure = "Present"
        Contents = $ConfigurationData.NonNodeData.FileText
        DestinationPath = "c:\file.txt"
    }
    
    file DnnInstallFiles
    {
        Ensure = "Present"
        Type = 'Directory'
        Recurse = $true
        SourcePath = 'c:\vagrant\dnn\install\'
        DestinationPath = "c:\inetpub\wwwroot\lab-a"
    }
    
    <#
    Archive UnzipDNN
    {
        Path = 'c:\vagrant\dnn\dnnInstall.zip'
        Destination = 'c:\inetpub\wwwroot\lab-a'
        Ensure = 'Present'
    }
    #>
    
    
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
    xWebSite Default
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
    }
    
    XWebsite DemoSite
    {
        Name = 'Demo'
        PhysicalPath = 'c:\inetpub\wwwroot\lab-a'
        State = 'Started'
        DependsOn = '[xWebsite]Default'
    }
    
    cNtfsPermissionEntry SiteNTFSPermissions
    {
        Ensure = 'Present'
        Path = 'c:\inetpub\wwwroot\lab-a'
        Principal = 'IIS APPPOOL\DefaultAppPool'
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'Modify'
                Inheritance = 'ThisFolderSubfoldersAndFiles'
                NoPropagateInherit = $false
            }
        )
        #DependsOn = '[File]TestDirectory'
    }
    
    xSQLServerDatabase DnnInstanceDB
    {
        Database = 'lab-a'
        Ensure = 'Present'
    }
    
    xSQLServerLogin DnnInstanceSQL
    {
        Name = 'IIS APPPOOL\DefaultAppPool'
        LoginType = 'WindowsGroup'
    }
    
    xSQLServerDatabaseRole DnnDbo
    {
        Name = 'IIS APPPOOL\DefaultAppPool'
        Database = 'lab-a'
        Role = 'db_owner'
        Ensure = 'Present'
    }
}