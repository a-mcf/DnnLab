# copy DSC resources into system module path.
$destinationPath = Join-Path -Path $env:ProgramFiles -ChildPath "WindowsPowerShell\Modules\"

if (Test-Path "c:\vagrant\") 
{
    $resourcePath = "c:\vagrant\dsc\resources"
}
else 
{
    $resourcePath = (Get-Location).Path
}

$dscResources = Get-ChildItem -Directory -Path $resourcePath

$dscResources | ForEach-Object {
    if (!(Test-Path (Join-Path -Path $destinationPath -ChildPath $_.Name))) 
    {
        Write-Host "Copying $($_.FullName)"
        Copy-Item -Path $_.FullName -Destination $destinationPath -Recurse
    }
}
