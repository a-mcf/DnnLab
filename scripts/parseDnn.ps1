function parseDNN
{
    param(
        [String]
        $Path = 'C:\users\amcfa\source\bitbucket\DnnLab\dnn\installLog.html',
        
        [Switch]
        $ShowNoMatch
    )

    $generalRex = "(?<time>\d{2}:\d{2}:\d{2}.\d{3})\s-(&nbsp;)*(?<action>[\w\.\s_-]*)(:)?(\s*)?(?<item>[\w\.\s_-]*)&nbsp;<font color='\w*'>(?<status>\w*)</font>"
    $packageRex = "(?<time>\d{2}:\d{2}:\d{2}.\d{3})\s-(&nbsp;)*(?<action>Installing Package File)(\s*)?(?<item>[\w\.\s_-]*)(:\s)?&nbsp;<font color='\w*'>(?<status>\w*)</font>"

    (Get-Content $Path) -split '<br>' | ForEach-Object {
        if ($matches) { $matches.clear() }
        
        $matchFound = $_ -match $generalRex

        if ($matchFound)
        {
            if ($matches['action'] -like "*Package File*")
            {
                $matches.Clear()
                $_ -match $packageRex |
                    Out-Null
                
                [PSCustomObject] @{
                    Time = $matches['time']
                    Action = $matches['action']
                    Item = $matches['item']
                    Status = $matches['status']
                }
            }
            else
            {
                [PSCustomObject] @{
                    Time = $matches['time']
                    Action = $matches['action']
                    Item = $matches['item']
                    Status = $matches['status']
                }
            }
        }
        else
        {
            if ($ShowNoMatch)
            {
                [PSCustomObject] @{
                    Time = "no match"
                    Action = $_
                    Item = "no match"
                    Status = "no match"
                }
            }
        }
    }
}

$output = parseDNN

$output