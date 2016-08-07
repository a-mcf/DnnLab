Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xNetworking'
    Import-DscResource -ModuleName 'cChoco'

    # composite resources
    Import-DscResource -ModuleName 'DnnWebserverConfig'
    Import-DscResource -ModuleName 'DnnDatabaseConfig'
    Import-DscResource -ModuleName 'ScriptResources'

    DnnWebserverRoles DnnLabWebRoles
    {
        Ensure = "Present"
    }
    
    foreach ($instance in $ConfigurationData.Dnn.Instance)
    {
        $instancePath = $null
        $instancePath = Join-Path $ConfigurationData.Dnn.WebRoot $instance.Name
        
        InstallFileCopy "DnnInstallFiles$($instance.Name -replace '\W','')"
        {
            Source = 'c:\vagrant\dnn\install{0}\' -f $instance.InstallVersion
            Destination = $instancePath
        }

        DnnWebsite "DnnLabWebsite$($instance.Name -replace '\W','')"
        {
            Name = $instance.Name
            HostName = $instance.Name
            Path = $instancePath
            PortalInfo = $instance.Portal
        }
                
        cNtfsPermissionEntry "SiteNTFSPermissions$($instance.Name -replace '\W','')"
        {
            Ensure = 'Present'
            Path = $instancePath
            Principal = "IIS APPPOOL\$($instance.Name)"
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

        ConnectionStrings "DnnConnectionString$($instance.Name -replace '\W','')"
        {
            WebsitePath = $instancePath
            SQLServer = "(local)"
            DatabaseName = $instance.Name
        }

        DnnDatabase "DnnSqlDatabase$($instance.Name -replace '\W','')"
        {
                DatabaseName = $instance.Name
                WebUser = "IIS APPPOOL\$($instance.Name)"
                WebUserLoginType = 'WindowsGroup'
                Ensure = 'Present'
        }

        xHostsFile "Hostsfile$($instance.Name -replace '\W','')"
        {
            HostName = $instance.Name
            IPAddress = "127.0.0.1"
            Ensure = 'Present'
        }

        InstallDnn "Install$($instance.Name)"
        {
            Host = $instance.Name
            Path = $instancePath
        }
    }
}