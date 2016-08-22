Configuration DnnIndexPage
{
    param(
        [Parameter(Mandatory=$true)]
        [System.Object[]]
        $InstanceData,

        [String]
        $Path
    )

    Import-DscResource -ModuleName 'xWebAdministration'
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    $portalData = foreach ($instance in $instanceData)
    {
        foreach ($portal in $instance.Portal)
        {
            [PSCustomObject] @{
                Instance = $instance.Name
                Version = $instance.InstallVersion
                Portal = '<a href="{0}://{1}">{0}://{1}</a>' -f (($portal.Protocol).ToLower()), $portal.HostName
            }
        }
    }

    # table taken from here:
    # http://cssmenumaker.com/blog/stylish-css-tables-tutorial
    $css = @"
    table {
        color: #333; /* Lighten up font color */
        font-family: Helvetica, Arial, sans-serif; /* Nicer font */
        width: 640px;
        border-collapse:
        collapse; border-spacing: 0;
        }

        td, th { border: 1px solid #CCC; height: 30px; } /* Make cells a bit taller */

        th {
        background: #F3F3F3; /* Light grey background */
        font-weight: bold; /* Make sure they're bold */
        }

        td {
        background: #FAFAFA; /* Lighter grey background */
        text-align: center; /* Center our text */
    }
"@

    Add-Type -AssemblyName System.Web
    $html = [System.Web.HttpUtility]::HtmlDecode($($portalData | ConvertTo-Html -Title "Portal Index" -CssUri "/index.css"))
    
    File 'SiteIndexDirectory'
    {
        DestinationPath = $Path
        Type = 'Directory'
        Ensure = 'Present'
    }
    
    File 'SiteIndex'
    {
        DestinationPath = Join-Path -Path $Path -ChildPath "index.html"
        Contents = $html
        Type = 'File'
        Ensure = 'Present'
        DependsOn = '[File]SiteIndexDirectory'
    }

    File 'SiteIndexCss'
    {
        DestinationPath = Join-Path -Path $Path -ChildPath "index.css"
        Contents = $css
        Type = 'File'
        Ensure = 'Present'
        DependsOn = '[File]SiteIndexDirectory'
    }
    
    xWebAppPool 'DnnLabIndexAppPool'
    {
        Name = 'DnnLabIndex'
        Ensure = 'Present'
    }
    
    xWebsite 'DnnLabIndexWeb'
    {
        Name = 'DnnLabIndex'
        PhysicalPath = $Path 
        State = 'Started'
        ApplicationPool = 'DnnLabIndex'
        DependsOn = '[xWebAppPool]DnnLabIndexAppPool','[File]SiteIndexDirectory'
    }
}