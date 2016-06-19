Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xNetworking'

    # composite resources
    Import-DscResource -ModuleName 'DnnWebserverConfig'
    Import-DscResource -ModuleName 'DnnDatabaseConfig'
    
    # using this instead of the file resource, because we only
    # want a one-time copy. The file resource was repopulating
    # the /install folder after modules were installed and removed.
    Script InstallFileCopy
    {
        GetScript = {
            @{
                PathExists = Test-Path -Path (Join-Path -Path $using:ConfigurationData.DnnSiteData.DotNetNukePath -ChildPath "\Install\")
            }
        }
        SetScript = {
            Copy-Item -Recurse -Path 'c:\vagrant\dnn\install\' -Destination $using:ConfigurationData.DnnSiteData.DotNetNukePath
        }
        TestScript = {
            Test-Path -Path (Join-Path -Path $using:ConfigurationData.DnnSiteData.DotNetNukePath -ChildPath "\Install\")
        }
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
        DependsOn = '[Script]InstallFileCopy'
    }

    $webConfigPath = Join-Path -Path $ConfigurationData.DnnSiteData.DotNetNukePath -ChildPath "web.config"   
    Script ConnectionString
    {
        GetScript = {
            $webConfigXml = (Get-Content $using:webConfigPath) -as [XML]
            @{
                SiteSQLServer = $webConfigXml.configuration.connectionStrings.add.connectionString 
            }              
        }
        SetScript = {
            $webConfigXml = (Get-Content $using:webConfigPath) -as [XML]
            $webConfigXml.configuration.connectionStrings.add.connectionString = "Server=(local);Database=lab-a;Integrated Security=True"
            $webConfigXml.Save($using:webConfigPath)
        }
        TestScript = {
            $webConfigXml = (Get-Content $using:webConfigPath) -as [XML]
            $webConfigXml.configuration.connectionStrings.add.connectionString -eq "Server=(local);Database=lab-a;Integrated Security=True"
        }      
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
        HostName = 'DnnSQL'
        IPAddress = '127.0.0.1'
        Ensure = 'Present'
    }
}