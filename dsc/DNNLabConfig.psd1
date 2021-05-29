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
                "9.3.2" = 'https://github.com/dnnsoftware/Dnn.Platform/releases/download/v9.3.2/DNN_Platform_9.3.2.24_Install.zip'
                "9.2.2" = 'https://github.com/dnnsoftware/Dnn.Platform/releases/download/v9.2.2/DNN_Platform_9.2.2.178_Install.zip'
            }
        }
        WebRoot = 'c:\inetpub\wwwroot'
        Instance = @(
            @{
                Name = "lab-a"
                InstallVersion = '9.3.2'
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
                InstallVersion = '9.2.2'
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
        #DownloadUrl = 'https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe'
        #Arguments = '/Action=Install /q /IAcceptSQLServerLicenseTerms /InstanceName=MSSQLSERVER /ROLE=AllFeatures_WithDefaults /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /ADDCURRENTUSERASSQLADMIN="True"'
        #ProductId = 'C3525BF7-3698-4CD3-A8C3-69BD6F57BA3B'
        Engine = @{
            # SQL Express 2012 SP3
            # DownloadUrl = 'https://download.microsoft.com/download/F/6/7/F673709C-D371-4A64-8BF9-C1DD73F60990/ENU/x64/SQLEXPR_x64_ENU.exe'
            # ProductId = ??

            # SQL Express 2016 R2 SP2
            #DownloadUrl = 'https://download.microsoft.com/download/3/7/6/3767D272-76A1-4F31-8849-260BD37924E4/SQLServer2016-SSEI-Expr.exe'
            # SQL Express 2008 R2 SP2
            # DownloadUrl = 'https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe'
            # ProductId   = 'C3525BF7-3698-4CD3-A8C3-69BD6F57BA3B'
            
            DownloadUrl = 'https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLEXPR_x64_ENU.exe'
            ProductId   = 'C3525BF7-3698-4CD3-A8C3-69BD6F57BA3B'
            Arguments   = '/Action=Install /q /IAcceptSQLServerLicenseTerms /InstanceName=MSSQLSERVER /ROLE=AllFeatures_WithDefaults /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /ADDCURRENTUSERASSQLADMIN="True"'
        }
        Sms = @{
            # SQL Express Management Studio 2008 R2
            #DownloadUrl = 'http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe'
            #ProductId = '72AB7E6F-BC24-481E-8C45-1AB5B3DD795D'
            #Arguments = '/Action=Install /FEATURES=CONN,BC,SSMS /IACCEPTSQLSERVERLICENSETERMS /Q'
        }
}
