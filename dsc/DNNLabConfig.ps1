Configuration DNNLabConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'xWebAdministration'
    Import-DscResource -ModuleName 'cNtfsAccessControl'
    Import-DscResource -ModuleName 'xSQLServer'
    
    
    # using this instead of the file resource, because we only
    # want a one-time copy. The file resource was repopulating
    # the /install folder after modules were installed  and removed.
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
    
    xWebSite DefaultWebSite
    {
        Name = 'Default Web Site'
        Ensure = 'Present'
        State = 'Stopped'
    }
    
    xWebsite DemoSite
    {
        Name = 'Demo'
        PhysicalPath = 'c:\inetpub\wwwroot\lab-a'
        State = 'Started'
        DependsOn = '[xWebsite]DefaultWebSite'
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
        #DependsOn = '[File]TestDirectory'
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