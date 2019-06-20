Configuration DnnInstallFiles
{
    param(
        [Parameter(mandatory=$true)]
        $DnnInstallCachePath,
        
        [Parameter(mandatory=$true)]
        $DnnVersion,
        
        [Parameter(mandatory=$true)]
        $DownloadCachePath,
        
        [Parameter(mandatory=$true)]
        $DownloadUrl
    )

    $zipPath = Join-Path -Path $DownloadCachePath -ChildPath "\dnnInstall$($DnnVersion).zip"
    $extractPath = Join-Path -Path $DnnInstallCachePath -ChildPath "\install$($DnnVersion)"
    
    Script DownloadDNN
    {
        GetScript = {
            ZipExists = Test-Path -Path $using:zipPath
        }
        SetScript = {
            if (!(Test-Path $using:DownloadCachePath))
            {
                mkdir $using:DownloadCachePath
            }
            $allTls = [enum]::GetNames([Net.SecurityProtocolType]) |
                Where-Object { $_ -notmatch "Ssl3" }

            # enable specified protocols
            [System.Net.ServicePointManager]::SecurityProtocol = $allTls

            Write-Verbose "Downloading DNN $($using:DnnVersion) to $using:zipPath"
            (New-Object System.Net.WebClient).DownloadFile($using:DownloadUrl,$using:zipPath)
        }
        TestScript = {
            Test-Path -Path $using:zipPath
        }
    }

    Script ExtractDnn
    {
        GetScript = {
            ExtractedPathExists = Test-Path -Path (Join-Path $using:extractPath "web.config") 
        }
        TestScript = {
            $webConfigExists = Test-Path -Path (Join-Path $using:extractPath "web.config")

            if ($webConfigExists)
            {
                Write-Verbose "Web.Config exists, assuming archive has been extracted"
            }
            else 
            {
                Write-Verbose "Web.Config does not exist, archive must be extracted."    
            }
            $webConfigExists
        }
        SetScript = {
            # this seems to hang. Dunno why.
            #Expand-Archive -Path $using:zipPath -DestinationPath $using:extractPath -Force
            
            if (Test-Path -Path $using:extractPath)
            {
                Write-Verbose "Removing directory found at $($using:extractPath)"
                Remove-Item -Path $using:extractPath -Recurse
            }
            
            Write-Verbose "Extracting $using:zipPath to $using:extractPath"
            Add-Type -AssemblyName "System.IO.Compression.FileSystem"
            [System.IO.Compression.ZipFile]::ExtractToDirectory($using:zipPath, $using:extractPath)
        }
        DependsOn = '[Script]DownloadDNN'
    }
}
