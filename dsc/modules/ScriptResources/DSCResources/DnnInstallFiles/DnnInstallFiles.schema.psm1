Configuration DnnInstallFiles
{
    param(
        [Parameter(mandatory=$true)]
        $DnnInstallCachePath,
        [Parameter(mandatory=$true)]
        $DnnVersion,
        [Parameter(mandatory=$true)]
        $DownloadUrl
    )

    $zipPath = Join-Path -Path $DnnInstallCachePath -ChildPath "\dnnInstall$($DnnVersion).zip"
    $extractPath = Join-Path -Path $DnnInstallCachePath -ChildPath "\install$($DnnVersion)"
    
    Write-Verbose "Downloading DNN $($DnnVersion) to $zipPath"
    Script DownloadDNN
    {
        GetScript = {
            ZipExists = Test-Path -Path $using:zipPath
        }
        SetScript = {
            if (!(Test-Path $using:DnnInstallCachePath))
            {
                mkdir $using:DnnInstallCachePath
            }
            (New-Object System.Net.WebClient).DownloadFile($using:DownloadUrl,$using:zipPath)
        }
        TestScript = {
            Test-Path -Path $using:zipPath
        }
    }

    Write-Verbose "Extracting $zipPath to $extractPath"
    Script ExtractDnn
    {
        GetScript = {
            ExtractedPathExists = Test-Path -Path (Join-Path $using:extractPath "web.config") 
        }
        TestScript = {
            Test-Path -Path (Join-Path $using:extractPath "web.config")
        }
        SetScript = {
            Expand-Archive -Path $using:zipPath -DestinationPath $using:extractPath
        }
    }
}
