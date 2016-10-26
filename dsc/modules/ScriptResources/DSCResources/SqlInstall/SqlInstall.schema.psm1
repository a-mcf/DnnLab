Configuration SqlInstall
{
    param(
        [Parameter(Mandatory=$true)]
        $Path,
        
        [Parameter(Mandatory=$true)]
        $Arguments,

        [Parameter(Mandatory=$true)]
        $ProductId,

        [Int[]]
        $ValiExitCode = @(0)
    )

    Script InstallSql
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
            $productId = Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -eq "{$($using:ProductId)}" }
            if ($productId)
            {
                Write-Verbose "$productId found."
                $true
            }
            else 
            {
                Write-Verbose "$productId not found."
                $false    
            }
        }
    }
} 