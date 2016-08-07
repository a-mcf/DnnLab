Configuration InstallFileCopy 
{
    param(
        $Source,
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
            Copy-Item -Recurse -Path $using:Source -Destination $using:Destination
        }
        TestScript = {
            Test-Path -Path (Join-Path -Path $using:Destination -ChildPath "\Install\")
        }
    }

}