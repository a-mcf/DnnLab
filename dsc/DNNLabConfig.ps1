Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xNetworking'

    # composite resources
    Import-DscResource -ModuleName 'DnnWebserverConfig'
    Import-DscResource -ModuleName 'DnnDatabaseConfig'
    Import-DscResource -ModuleName 'ScriptResources'
    

    InstallFileCopy DnnInstallFiles
    {
        Source = 'c:\vagrant\dnn\install\'
        Destination = $ConfigurationData.DnnSiteData.DotNetNukePath
    }

    DnnWebserverRoles DnnLabWebRoles
    {
        Ensure = "Present"
    }

    DnnWebsite DnnLabWebsite
    {
        Name = $ConfigurationData.DnnSiteData.Name
        Path = $ConfigurationData.DnnSiteData.DotNetNukePath
    }
            
    cNtfsPermissionEntry SiteNTFSPermissions
    {
        Ensure = 'Present'
        Path = $ConfigurationData.DnnSiteData.DotNetNukePath
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
        #DependsOn = '[Script]InstallFileCopy'
    }

    ConnectionStrings DnnConnectionString
    {
        WebsitePath = $ConfigurationData.DnnSiteData.DotNetNukePath
        SQLServer = "(local)"
        #SQLServer = $ConfigurationData.DnnSiteData.Name + "-SQL"
        DatabaseName = $ConfigurationData.DnnSiteData.Name
    }

    DnnDatabase DnnSqlDatabase
    {
            DatabaseName = $ConfigurationData.DnnSiteData.Name
            WebUser = 'IIS APPPOOL\DefaultAppPool'
            WebUserLoginType = 'WindowsGroup'
            Ensure = 'Present'
    }

    xHostsFile SQLHostsEntry
    {
        HostName = $ConfigurationData.DnnSiteData.Name + "-SQL"
        IPAddress = $ConfigurationData.DnnSiteData.SQLServerIP
        Ensure = 'Present'
    }
}