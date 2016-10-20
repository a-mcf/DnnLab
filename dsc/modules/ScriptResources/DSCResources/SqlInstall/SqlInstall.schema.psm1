Configuration SqlInstall
{
    param(
        [Parameter(Mandatory=$true)]
        $Path,
        
        [Parameter(Mandatory=$true)]
        $Arguments,

        [Int[]]
        $ValiExitCode = @(0)
    )

    Script InstallDnn
    {
        GetScript = {
            @{
                ProducCode = Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -eq "{$($using:Arguments)}" }
            }
        }
        SetScript = {
            Start-Process -FilePath $using:Path -ArgumentList $using:Arguments -Wait
            if ($using:ValidExitCode -contains $LASTEXITCODE) 
            {
                Write-Verbose "Package Installed"
            }
            else 
            {
                Write-Error "unable to install package"    
            }
        }
        TestScript = {
            $productId = Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -eq "{$($using:Arguments)}" }
            if ($productId)
            {
                $true
            }
            else 
            {
                $false    
            }
        }
    }
} 