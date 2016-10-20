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
    Dnn = @{
        Install = @{
            CachePath = 'c:\vagrant\dnn'
            DownloadUrl = @{
                "7.4.2" = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1493875&FileTime=130885394216030000&Build=21031'
                "8.0.3" = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1574135&FileTime=131087835783300000&Build=21031'
                "8.0.4" = "https://github.com/dnnsoftware/Dnn.Platform/releases/download/v8.0.4/DNN_Platform_8.0.4.226_Install.zip"
            }
        }
        WebRoot = 'c:\inetpub\wwwroot'
        Instance = @(
            @{
                Name = "lab-a"
                InstallVersion = '7.4.2'
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
                InstallVersion = '8.0.4'
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
            # SQL Express 2012 SP3
            # DownloadUrl = 'https://download.microsoft.com/download/F/6/7/F673709C-D371-4A64-8BF9-C1DD73F60990/ENU/x64/SQLEXPR_x64_ENU.exe'
            # ProductId = ??

            # SQL Express 2008 R2 SP2
            DownloadUrl = 'https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe'
            # engine -DownloadUrl = 'https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x64_ENU.exe'
            ProductId = 'C3525BF7-3698-4CD3-A8C3-69BD6F57BA3B'
            Arguments = '/Action=Install /q /IAcceptSQLServerLicenseTerms /InstanceName=MSSQLSERVER /ROLE=AllFeatures_WithDefaults /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /ADDCURRENTUSERASSQLADMIN="True"'        }
        Sms = @{
            # SQL Express Management Studio 2008 R2
            DownloadUrl = 'http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe'
            ProductId = '72AB7E6F-BC24-481E-8C45-1AB5B3DD795D'
            Arguments = '/Action=Install /FEATURES=CONN,BC,SSMS /IACCEPTSQLSERVERLICENSETERMS /Q'
        }
    }
    
    # fake - added to make VSCode happy.
    ModuleVersion = '1.0'
}
