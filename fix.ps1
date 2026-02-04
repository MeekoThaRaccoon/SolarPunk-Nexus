# FIX ALL REPOS IN ONE CLICK
Write-Host "=== FIXING GITHUB FOR MEEKOTHARACCOON ===" -f Cyan

# List of your repos
$repos = @(
    "SolarPunk",
    "connected", 
    "SolarPunk-Autonomous",
    "SolarPunk-Nexus"
)

foreach ($r in $repos) {
    $path = "C:\Users\carol\SolarPunk\$r"
    if (Test-Path $path) {
        Write-Host "`nFixing: $r" -f Yellow
        cd $path
        git remote set-url origin "https://github.com/MeekoThaRaccoon/$r.git"
        git push origin master
    }
}

Write-Host "`n=== DONE! ===" -f Green
Write-Host "Check: https://github.com/MeekoThaRaccoon" -f Cyan
pause