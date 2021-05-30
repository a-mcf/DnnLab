Configuration DnnDatabase 
{
    param(
        [Parameter(Mandatory=$true)]
        $DatabaseName,
        
        [Parameter(Mandatory=$true)]
        $WebUser,

        $WebUserLoginType = 'WindowsGroup',

        $SQlServer = 'localhost',
        
        $SQlServerInstanceName = 'MSSQLSERVER', 
        
        $Ensure = 'Present'
    )

    Import-DscResource -ModuleName 'xSQLServer'

    
    xSQLServerDatabase "DnnInstanceDB"
    {
        Name            = $DatabaseName
        SQLServer       = $SQlServer
        SQLInstanceName = $SQlServerInstanceName
        Ensure          = $Ensure
    }
    
    xSQLServerLogin "DnnInstanceSQL"
    {
        Name            = $WebUser
        LoginType       = $WebUserLoginType
        SQLServer       = $SQlServer
        SQLInstanceName = $SQlServerInstanceName
        Ensure          = 'Present'

    }
    
    xSQLServerDatabaseRole "DnnDbo"
    {
        Name            = $Webuser
        Database        = $DatabaseName
        Role            = 'db_owner'
        SQLServer       = $SQlServer
        SQLInstanceName = $SQlServerInstanceName
        Ensure          = $Ensure
        
        DependsOn = '[xSqlServerDatabase]DnnInstanceDB', '[xSQLServerLogin]DnnInstanceSQL'
    }
    #>
}