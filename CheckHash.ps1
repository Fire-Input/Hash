$Match = 0
$NoMatch = 0
$newlines = @()

$File = Get-Content .\sha256sum.txt | ForEach-Object {
    $Values = [string]$_ -Split("  "), 0
    $fileHash = (Get-FileHash -LiteralPath $Values[1]).Hash
    if ($fileHash -eq $Values[0]) {
        $Match = $Match+1
        #"Files = $Values[1]`nOriginal Hash = $Values[0]" | Out-File ./Matches.txt
    }
    else {
        $NoMatch = $NoMatch+1
        Write-Host "$Values[0]"
        $Line = "Original Hash = $Values[0]`nFile = $Values[1]`n"
        $newlines += $Line
       
    }
}

if ($NoMatch -eq 0) {
    Write-Host "All $Match Files Match!"
}
else {
    Write-Host "Matches: $Match"
    Write-Host "Failed to Match: $NoMatch"
    $newlines | out-file .\Failed.txt
}
Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")