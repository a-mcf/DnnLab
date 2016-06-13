Configuration DnnDatabase 
{
    param(
        $DatabaseName = 'lab-a',
        $WebUser = 'IIS APPPOOL\DefaultAppPool',
        $WebUserLoginType = 'WindowsGroup',
        $Ensure = 'Present'
    )

    Import-DscResource -ModuleName 'xSQLServer'

    xSQLServerDatabase DnnInstanceDB
    {
        Database = $DatabaseName
        Ensure = $Ensure
    }
    
    xSQLServerLogin DnnInstanceSQL
    {
        Name = $WebUser
        LoginType = $WebUserLoginType
    }
    
    xSQLServerDatabaseRole DnnDbo
    {
        Name = $Webuser
        Database = $DatabaseName
        Role = 'db_owner'
        Ensure = $Ensure
        DependsOn = '[xSQLServerLogin]DnnInstanceSQL'
    }
}