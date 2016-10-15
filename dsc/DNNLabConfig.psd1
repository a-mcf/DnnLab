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
        Engine = {
            #DownloadUrl = 'https://download.microsoft.com/download/0/F/D/0FD88169-F86F-46E1-8B3B-56C44F6E9505/SQLEXPR_x64_ENU.exe'
            DownloadUrl = 'http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x64_ENU.exe'
            InstallConfigFile = @'
[SQLServer2008]
INSTANCEID="MSSQLSERVER"
ACTION="Install"
FEATURES=SQLENGINE
HELP="False"
INDICATEPROGRESS="False"
X86="False"
ERRORREPORTING="False"
SQMREPORTING="False"
INSTANCENAME="MSSQLSERVER"
SQLSVCSTARTUPTYPE="Automatic"
ENABLERANU="True"
SQLCOLLATION="SQL_Latin1_General_CP1_CI_AS"
SQLSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE"
SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS"
SECURITYMODE="SQL"
ADDCURRENTUSERASSQLADMIN="True"
SAPWD="Vagrant2016!"
TCPENABLED="1"
NPENABLED="0"
BROWSERSVCSTARTUPTYPE="Disabled"
'@   
        }
        Sms = {
            DownloadUrl = 'http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe'
        }

    }
    
    # fake - added to make VSCode happy.
    ModuleVersion = '1.0'
}
