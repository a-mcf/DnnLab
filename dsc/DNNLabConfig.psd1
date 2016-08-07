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
        InstallVersion = @{
            7 = @{
                DownloadUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1493875&FileTime=130885394216030000&Build=21031'
            }
            8 = @{
                DownloadUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1574135&FileTime=131087835783300000&Build=21031'
            }
        }
        WebRoot = 'c:\inetpub\wwwroot'
        Instance = @(
            @{
                Name = "lab-a"
                InstallVersion = '7'
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
                InstallVersion = '7'
                Portal = @(
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-b'
                    }
                )
            }
            @{
                Name = "lab-c"
                InstallVersion = '7'
                Portal = @(
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-c'
                    }
                    @{
                        Port = 80
                        Protocol = 'HTTP'
                        IPAddress = '*'
                        HostName = 'lab-c1'
                    }
                )
            }
        )
    }
    
    # fake - added to make VSCode happy.
    ModuleVersion = '1.0'
}
