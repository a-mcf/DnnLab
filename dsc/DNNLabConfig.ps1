Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xNetworking'

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
        
        $dnnInstallFiles = "DnnInstallFiles$($instance.Name -replace '\W','')"
        DnnInstallFiles $dnnInstallFiles
        {
            DnnInstallCachePath = $ConfigurationData.Dnn.Install.CachePath
            #DownloadUrl = $Configuration.Dnn.Install.DownloadUrl."$($instance.InstallVersion)"
            DownloadUrl = $ConfigurationData.Dnn.Install.DownloadUrl[$instance.InstallVersion]
            DnnVersion = $instance.InstallVersion
        }
    
        $installFileCopy = "DnnInstallCopy$($instance.Name -replace '\W','')"
        InstallFileCopy $installFileCopy
        {
            #Source = 'c:\vagrant\dnn\install{0}\' -f $instance.InstallVersion
            Source = Join-Path $ConfigurationData.Dnn.Install.CachePath  ('\install{0}\' -f $instance.InstallVersion)
            Destination = $instancePath
        }

        $dnnWebsite = "DnnLabWebsite$($instance.Name -replace '\W','')" 
        DnnWebsite $dnnWebsite
        {
            Name = $instance.Name
            HostName = $instance.Name
            Path = $instancePath
            PortalInfo = $instance.Portal
        }
        
        $ntfsPermissionEntry = "SiteNTFSPermissions$($instance.Name -replace '\W','')"
        cNtfsPermissionEntry $ntfsPermissionEntry
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
            DependsOn = "[InstallFileCopy]$installFileCopy"
        }

        $connectionStrings = "DnnConnectionString$($instance.Name -replace '\W','')" 
        ConnectionStrings $connectionStrings
        {
            WebsitePath = $instancePath
            SQLServer = "(local)"
            DatabaseName = $instance.Name
        }
        
        $dnnDatabase = "DnnSqlDatabase$($instance.Name -replace '\W','')"
        DnnDatabase $dnnDatabase
        {
                DatabaseName = $instance.Name
                WebUser = "IIS APPPOOL\$($instance.Name)"
                WebUserLoginType = 'WindowsGroup'
                Ensure = 'Present'
        }

        #todo loop through bindings
        $hostsFile = "Hostsfile$($instance.Name -replace '\W','')" 
        xHostsFile $hostsFile
        {
            HostName = $instance.Name
            IPAddress = "127.0.0.1"
            Ensure = 'Present'
        }

        $installDnn = "Install$($instance.Name)"
        InstallDnn $installDnn
        {
            Host = $instance.Name
            Path = $instancePath
        }
    }
}