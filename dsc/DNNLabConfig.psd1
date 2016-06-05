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
    NonNodeData = @{
        #FileText = "This is the file text supplied from configuration data."
        DotNetNukePath = "c:\inetpub\wwwroot\lab-a"
    }
}