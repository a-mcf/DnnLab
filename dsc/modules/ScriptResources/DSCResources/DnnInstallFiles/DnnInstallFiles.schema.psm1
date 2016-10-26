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
            Write-Verbose "Extracting $using:zipPath to $using:extractPath"
            #Expand-Archive -Path $using:zipPath -DestinationPath $using:extractPath -Force
            Add-Type -AssemblyName "System.IO.Compression.FileSystem"
            [System.IO.Compression.ZipFile]::ExtractToDirectory($using:zipPath, $using:extractPath)
        }
        DependsOn = '[Script]DownloadDNN'
    }
}
