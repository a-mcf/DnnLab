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
        SQLServer = "localhost"
        Url = @(
            "localhost"
            "www.test.local"
        )
    }
}