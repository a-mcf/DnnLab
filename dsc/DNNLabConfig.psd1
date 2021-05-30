@{
    AllNodes = @(
        @{
            NodeName = "localhost"
            Roles = @(
                "Web"
                "SQL"
            )
        }
    )
    DownloadCachePath = 'c:\vagrant\download_cache'
    Dnn = @{
        Install = @{
            CachePath = 'c:\installCache'
            DownloadUrl = @{
                "9.9.1" = 'https://github.com/dnnsoftware/Dnn.Platform/releases/download/v9.9.1/DNN_Platform_9.9.1_Install.zip'
                #"9.2.2" = 'https://github.com/dnnsoftware/Dnn.Platform/releases/download/v9.2.2/DNN_Platform_9.2.2.178_Install.zip'
            }
        }
        WebRoot = 'c:\inetpub\wwwroot'
        Instance = @(
            @{
                Name = "lab-a"
                InstallVersion = '9.9.1'
                Portal = @(
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-a'
                    }
                )
            }
            @{
                Name = "lab-b"
                InstallVersion = '9.9.1'
                Portal = @(
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-b'
                    }
                    # removed until portal configuration is in place.
                    <#
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-b-1'
                    }
                    #>
                )
            }
        )
    }
    Sql = @{
        Engine = @{
            DownloadUrl = 'https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLEXPR_x64_ENU.exe'
            ProductId   = '17DCED0E-5B27-453A-B2B4-E487B869B28A'
            Arguments   = '/Action=Install /q /IAcceptSQLServerLicenseTerms /InstanceName=MSSQLSERVER /ROLE=AllFeatures_WithDefaults /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /ADDCURRENTUSERASSQLADMIN="True"'
        }
        Sms = @{
            # SQL Express Management Studio 2008 R2
            #DownloadUrl = 'http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe'
            #ProductId = '72AB7E6F-BC24-481E-8C45-1AB5B3DD795D'
            #Arguments = '/Action=Install /FEATURES=CONN,BC,SSMS /IACCEPTSQLSERVERLICENSETERMS /Q'
        }
    }
}