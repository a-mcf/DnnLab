Configuration InstallDnn
{
    param(
        [Parameter(Mandatory=$true)]
        $Host,
        
        [Parameter(Mandatory=$true)]
        $Path
    )

    $installHtml = Join-Path -Path $Path -ChildPath "installLog.html"
    $installFailedHtml = Join-Path -Path $Path -ChildPath "installLogFailed.html"
    $installUrl = 'http://{0}/Install/Install.aspx?mode=Install' -f $Host

    Script InstallDnn
    {
        GetScript = {
            @{
                DnnInstalled = Test-Path -Path $using:installHtml
            }
        }
        SetScript = {
            $allTls = [enum]::GetNames([Net.SecurityProtocolType]) |
            Where-Object { $_ -notmatch "Ssl3" }

            # enable specified protocols
            [System.Net.ServicePointManager]::SecurityProtocol = $allTls

            Invoke-WebRequest -UseBasicParsing -Uri $using:installUrl -OutFile $using:installHtml
            $installSuccess = Select-String -SimpleMatch "Successfully Installed Site" -Path $using:installHtml -Quiet
    
            if ($installSuccess)
            {
                Write-Verbose "Install Complete"
            }
            else 
            {
                Rename-Item $using:installHtml $using:installFailedHtml
                Write-Verbose "Install failed. See $($using:installFailedHtml) for details."
                Write-Error "Install failed. See $($using:installFailedHtml) for details."
            }
        }
        TestScript = {
            Test-Path -Path $using:installHtml
        }
    }
} 