Configuration ConnectionStrings {
    param(
        [Parameter(Mandatory=$true)]
        $WebsitePath,
        
        [Parameter(Mandatory=$true)]
        $SQLServer,
        
        [Parameter(Mandatory=$true)]
        $DatabaseName
    )

    $webConfigPath = Join-Path -Path $WebsitePath -ChildPath "Web.Config"
    $connectionString = "Server={0};Database={1};Integrated Security=True;" -f $SQLServer, $DatabaseName
    
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
            Write-Verbose "Setting connection string: $connectionString"
            $webConfigXml.configuration.connectionStrings.add.connectionString = $using:connectionString
            $webConfigXml.Save($using:webConfigPath)
        }
        TestScript = {
            $webConfigXml = (Get-Content $using:webConfigPath) -as [XML]
            $webConfigXml.configuration.connectionStrings.add.connectionString -eq $using:connectionString
        }      
    }

}