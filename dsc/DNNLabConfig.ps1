Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'xWebAdministration'
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
                PathExists = Test-Path -Path (Join-Path -Path $using:ConfigurationData.NonNodeData.DotNetNukePath -ChildPath "\Install\")
            }
        }
        SetScript = {
            Copy-Item -Recurse -Path 'c:\vagrant\dnn\install\' -Destination $using:ConfigurationData.NonNodeData.DotNetNukePath
        }
        TestScript = {
            Test-Path -Path (Join-Path -Path $using:ConfigurationData.NonNodeData.DotNetNukePath -ChildPath "\Install\")
        }
    }

    DnnWebserverRoles DnnLabWebRoles
    {
        Ensure = "Present"
    }

    DnnWebsite DnnLabWebsite
    {
        Ensure = "Present"
    }
            
    cNtfsPermissionEntry SiteNTFSPermissions
    {
        Ensure = 'Present'
        Path = $ConfigurationData.NonNodeData.DotNetNukePath
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

    $webConfigPath = Join-Path -Path $ConfigurationData.NonNodeData.DotNetNukePath -ChildPath "web.config"   
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
            DatabaseName = 'lab-a'
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