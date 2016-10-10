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
            Write-Verbose "Setting connection string: $using:connectionString"
            
            ($webConfigXml.configuration.connectionStrings.add | 
                Where-Object {$_.Name -eq "SiteSqlServer"}).connectionString = $using:connectionString
            
            $webConfigXml.configuration.appSettings.add | 
                Where-Object {$_.key -eq "SiteSqlServer"} | 
                    ForEach-Object {$_.value = $using:connectionString}
            
            $webConfigXml.Save($using:webConfigPath)
        }
        TestScript = {
            $webConfigXml = (Get-Content $using:webConfigPath) -as [XML]
            
            $connectionString = ($webConfigXml.configuration.connectionStrings.add | 
                Where-Object {$_.Name -eq "SiteSqlServer"}).connectionString -eq $using:connectionString
            
            $appSetting = $webConfigXml.configuration.appSettings.add | 
                Where-Object {$_.key -eq "SiteSqlServer"} | 
                    ForEach-Object {$_.value -eq $using:connectionString}
            
            if ($connectionString -and $appSetting)
            {
                $true
            }
            else 
            {
                $false    
            }
        }      
    }

}
