Configuration ChocolateyInstalls {
    param(
        $SQLPackage,
        $SQLPackageConfigFile
    )
    
    Script ChocolateyInstalls
    {
        GetScript = {
            $installedPackage = chocolatey list -localonly | Where-Object { $_ -match $using:SQLPackage }
            if ($installedPackage)
            {
                @{
                    package = $installedPackage
                }
            }
            else 
            {
                @{
                    package = $null
                }    
            }               
        }
        SetScript = {
            if ($using:SQLPackageConfigFile)
            {
                Write-Verbose "Installing $($using:SQLPackage) using config file $($using:SQLPackageConfigFile)"
                $sqlInstallArgs = " /ConfigurationFile=$($using:SQLPackageConfigFile)"
                choco install $using:SQLPackage -installargs $sqlInstallArgs -y
            }
            else 
            {
                choco install $SQLPackage -y   
            }
        }
        TestScript = {
            $package = $false
            $package = chocolatey list -localonly | Where-Object { $_ -match $using:SQLPackage }
            if ($package)
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