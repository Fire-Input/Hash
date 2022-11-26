#Add some threading to make it faster?
$Files = Get-ChildItem -Path ./ -Recurse -File -Exclude "sha256sum.txt"
$newlines = @()
ForEach ($File in $Files){
    $filename = $File.FullName
    $Format = (Get-FileHash -LiteralPath $filename)
    $Line = ($Format.Hash + "  " + $Format.Path)
    $newlines += $Line
}
$newlines | out-file .\sha256sum.txt

Write-Host "Checksum Created!"
Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")