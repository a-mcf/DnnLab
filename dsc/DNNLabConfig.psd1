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
                InstallVersion = '8.0.3'
                Portal = @(
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-b'
                    }
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-b-1'
                    }
                )
            }
        )
    }
    
    # fake - added to make VSCode happy.
    ModuleVersion = '1.0'
}
