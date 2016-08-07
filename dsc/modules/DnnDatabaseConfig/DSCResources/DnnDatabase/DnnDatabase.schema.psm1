Configuration DnnDatabase 
{
    param(
        $DatabaseName,
        $WebUser,
        $WebUserLoginType = 'WindowsGroup',
        $Ensure = 'Present'
    )

    Import-DscResource -ModuleName 'xSQLServer'

    xSQLServerDatabase "DnnInstanceDB"
    {
        Database = $DatabaseName
        Ensure = $Ensure
    }
    
    xSQLServerLogin "DnnInstanceSQL"
    {
        Name = $WebUser
        LoginType = $WebUserLoginType
    }
    
    xSQLServerDatabaseRole "DnnDbo"
    {
        Name = $Webuser
        Database = $DatabaseName
        Role = 'db_owner'
        Ensure = $Ensure
        DependsOn = '[xSqlServerDatabase]DnnInstanceDB', '[xSQLServerLogin]DnnInstanceSQL'
    }
}