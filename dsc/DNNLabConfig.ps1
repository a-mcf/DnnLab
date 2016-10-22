Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xNetworking'
    Import-DscResource -ModuleName xWebAdministration
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    # composite resources
    Import-DscResource -ModuleName 'DnnWebserverConfig'
    Import-DscResource -ModuleName 'DnnDatabaseConfig'
    Import-DscResource -ModuleName 'ScriptResources'

    <#
        can also try $global:DSCMachineStatus = 0
        if setting the LCM fails
    #>

    DnnWebserverRoles DnnLabWebRoles
    {
        Ensure = "Present"
    }

    xWebSite DefaultWebSite
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
        DependsOn = "[DnnWebServerRoles]DnnLabWebRoles"
    }

    DnnIndexPage SiteIndex
    {
        InstanceData = $ConfigurationData.Dnn.Instance
        Path = Join-Path $ConfigurationData.Dnn.WebRoot "DnnSiteIndex"
        DependsOn = "[xWebsite]DefaultWebsite"
    }

    xRemoteFile SqlEngineMsi
    {
        Uri = $ConfigurationData.Sql.Engine.DownloadUrl
        DestinationPath = Join-Path $ConfigurationData.Dnn.Install.CachePath "SqlExpress.exe"
        MatchSource = $false
    }

    <#
    xRemoteFile SqlSmsMsi
    {
        Uri = $ConfigurationData.Sql.Sms.DownloadUrl
        DestinationPath = Join-Path $ConfigurationData.Dnn.Install.CachePath "Sms.exe"
        MatchSource = $false
    }

    <#
    Package SqlEngine
    {
        Name = "SQL Server DB Engine"
        Path = Join-Path $ConfigurationData.Dnn.Install.CachePath "SqlEngine.exe"
        Arguments = $ConfigurationData.Sql.Engine.Arguments
        ProductId = $ConfigurationData.Sql.Engine.ProductId
    }
    #>

    SqlInstall SqlExpress
    {
        Path = Join-Path $ConfigurationData.Dnn.Install.CachePath "SqlExpress.exe"
        Arguments = $ConfigurationData.Sql.Engine.Arguments
    }
    
    foreach ($instance in $ConfigurationData.Dnn.Instance)
    {
        $instancePath = $null
        $instancePath = Join-Path $ConfigurationData.Dnn.WebRoot $instance.Name
        
        $dnnInstallFiles = "DnnInstallFiles$($instance.Name -replace '\W','')"
        DnnInstallFiles $dnnInstallFiles
        {
            DnnInstallCachePath = $ConfigurationData.Dnn.Install.CachePath
            DownloadUrl = $ConfigurationData.Dnn.Install.DownloadUrl[$instance.InstallVersion]
            DnnVersion = $instance.InstallVersion
            DependsOn = "[DnnWebServerRoles]DnnLabWebRoles"
        }
    
        $installFileCopy = "DnnInstallCopy$($instance.Name -replace '\W','')"
        InstallFileCopy $installFileCopy
        {
            Source = Join-Path $ConfigurationData.Dnn.Install.CachePath  ('\install{0}\' -f $instance.InstallVersion)
            Destination = $instancePath
            DependsOn = "[DnnInstallFiles]$dnnInstallFiles"
        }

        $dnnWebsite = "DnnLabWebsite$($instance.Name -replace '\W','')" 
        DnnWebsite $dnnWebsite
        {
            Name = $instance.Name
            HostName = $instance.Portal[0].HostName
            Path = $instancePath
            PortalInfo = $instance.Portal
            DependsOn = "[InstallFileCopy]$installFileCopy","[DnnWebserverRoles]DnnLabWebRoles"
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
            DependsOn = "[DnnWebSite]$dnnWebsite"
        }

        $connectionStrings = "DnnConnectionString$($instance.Name -replace '\W','')" 
        ConnectionStrings $connectionStrings
        {
            WebsitePath = $instancePath
            SQLServer = "(local)"
            DatabaseName = $instance.Name
            DependsOn = "[InstallFileCopy]$installFileCopy"
        }
        
        $dnnDatabase = "DnnSqlDatabase$($instance.Name -replace '\W','')"
        DnnDatabase $dnnDatabase
        {
                DatabaseName = $instance.Name
                WebUser = "IIS APPPOOL\$($instance.Name)"
                WebUserLoginType = 'WindowsGroup'
                Ensure = 'Present'
                DependsOn = "[DnnWebSite]$dnnWebsite","[SqlInstall]SqlExpress"
        }

        #todo loop through bindings
        $instance.Portal.ForEach({
            $hostsFile = "Hostsfile$($_.HostName -replace '\W','')" 
            xHostsFile $hostsFile
            {
                HostName = $_.HostName
                IPAddress = "127.0.0.1"
                Ensure = 'Present'
            }
        })

        $installDnn = "Install$($instance.Name)"
        InstallDnn $installDnn
        {
            Host = $instance.Name
            Path = $instancePath
            DependsOn = "[DnnWebSite]$dnnWebsite","[DnnDatabase]$dnnDatabase",
                "[ConnectionStrings]$connectionStrings"
        }
    }

    <#
    Package SqlSms
    {
        Name = "SQL Server Management Studio"
        Path = Join-Path $ConfigurationData.Dnn.Install.CachePath "Sms.exe"
        Arguments = $ConfigurationData.Sql.Sms.Arguments
        ProductId = $ConfigurationData.Sql.Sms.ProductId
    }
    #>
}