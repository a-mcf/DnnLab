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
            742 = @{
                DownloadUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1493875&FileTime=130885394216030000&Build=21031'
            }
            803 = @{
                DownloadUrl = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=dotnetnuke&DownloadId=1574135&FileTime=131087835783300000&Build=21031'
            }
        }
        WebRoot = 'c:\inetpub\wwwroot'
        Instance = @(
            @{
                Name = "lab-a"
                InstallVersion = '742'
            }
            @{
                Name = "lab-b"
                InstallVersion = '742'
            }
            @{
                Name = "lab-c"
                InstallVersion = '742'
            }
        )
    }
    
    # fake - added to make VSCode happy.
    ModuleVersion = '1.0'
}
