    $ver = (Get-ChildItem $env:USERPROFILE\.nuget\packages\Microsoft.CodeCoverage | Select-Object -Property Name | Sort-Object -Descending | Select-Object -First 1).Name
 
    Get-ChildItem -Recurse -Filter "*.coverage" | % {
    $outfile = "$([System.IO.Path]::GetFileNameWithoutExtension($_.FullName)).coveragexml"
    $output = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($_.FullName), $outfile)
    "Analyse '$($_.FullName)' with output '$output'..."
    . $env:USERPROFILE\.nuget\packages\microsoft.codecoverage\$ver\build\netstandard1.0\CodeCoverage\CodeCoverage.exe analyze /output:$output $_.FullName
    }
    Write-Host "Done"