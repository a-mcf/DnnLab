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
    DnnSiteData = @{
        Name = "lab-a"
        DotNetNukePath = "c:\inetpub\wwwroot\lab-a"
        Webroot = 'c:\WebRoot'
        SQLServerIP = "127.0.0.1"
    }
    # added to make VSCode happy
    ModuleVersion = '1.0'
}
