Configuration InstallFileCopy 
{
    param(
        [Parameter(Mandatory=$true)]
        $Source,
        
        [Parameter(Mandatory=$true)]
        $Destination
    )

    Script InstallFileCopy
    {
        GetScript = {
            @{
                PathExists = Test-Path -Path (Join-Path -Path $using:Destination -ChildPath "\Install\")
            }
        }
        SetScript = {
            Write-Verbose "Copying $($using:Source) to $($using:Destination)"
            Copy-Item -Recurse -Path $using:Source -Destination $using:Destination
        }
        TestScript = {
            Test-Path -Path (Join-Path -Path $using:Destination -ChildPath "\Install\")
        }
    }

}