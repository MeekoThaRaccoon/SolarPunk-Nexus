# Smart_Repo_Fixer.ps1
Write-Host "=== SolarPunk Repository Auditor ===" -ForegroundColor Cyan
Write-Host "Scanning for local Git repositories..." -ForegroundColor Yellow

# Find all .git folders starting from the SolarPunk directory
$basePath = "C:\Users\carol\SolarPunk"
$gitFolders = Get-ChildItem -Path $basePath -Directory -Recurse -Filter ".git" -Force

Write-Host "Found $($gitFolders.Count) local repositories:" -ForegroundColor Green

$repoList = @()

foreach ($gitFolder in $gitFolders) {
    $repoPath = $gitFolder.Parent.FullName
    $repoName = $gitFolder.Parent.Name
    
    # Get Git status safely
    Push-Location $repoPath
    $remoteUrl = (git remote get-url origin 2>$null)
    $branchStatus = (git status --porcelain 2>$null)
    Pop-Location
    
    $repoInfo = [PSCustomObject]@{
        Name = $repoName
        Path = $repoPath
        Remote = $remoteUrl
        HasChanges = -not [string]::IsNullOrEmpty($branchStatus)
    }
    
    $repoList += $repoInfo
    
    # Display status
    $statusSymbol = if ($remoteUrl) { "✓" } else { "✗" }
    $changeSymbol = if ($repoInfo.HasChanges) { "*" } else { " " }
    Write-Host "  $statusSymbol$changeSymbol $repoName" -ForegroundColor $(if ($remoteUrl) { 'Gray' } else { 'DarkYellow' })
}

# Show menu for user to choose
Write-Host "`n=== What would you like to do? ===" -ForegroundColor Cyan
Write-Host "1. See detailed status of all repos"
Write-Host "2. Fix ONE repository (you choose)"
Write-Host "3. Open YOUR GitHub Repositories page in browser"
Write-Host "4. Exit"
Write-Host "`nEnter choice (1-4): " -NoNewline -ForegroundColor Yellow

$choice = Read-Host

switch ($choice) {
    '1' {
        $repoList | Format-Table Name, @{Label="Remote"; Expression={if($_.Remote){'Configured'}else{'Missing'}}}, HasChanges -AutoSize
        Write-Host "`nNote: Repos with changes (*) need 'git add .' and 'git commit' first." -ForegroundColor Gray
    }
    '2' {
        Write-Host "`nSelect a repository to fix:" -ForegroundColor Yellow
        for ($i=0; $i -lt $repoList.Count; $i++) {
            Write-Host "$($i+1). $($repoList[$i].Name)"
        }
        Write-Host "`nEnter number: " -NoNewline -ForegroundColor Yellow
        $repoChoice = [int](Read-Host) - 1
        
        if ($repoChoice -ge 0 -and $repoChoice -lt $repoList.Count) {
            $selectedRepo = $repoList[$repoChoice]
            Write-Host "`nFixing: $($selectedRepo.Name)" -ForegroundColor Magenta
            Push-Location $selectedRepo.Path
            
            # Step-by-step fix
            Write-Host "1. Setting remote URL..." -ForegroundColor Gray
            git remote remove origin 2>$null
            git remote add origin "https://github.com/MeekoThaRaccoon/$($selectedRepo.Name).git"
            
            if ($selectedRepo.HasChanges) {
                Write-Host "2. You have uncommitted changes. Commit first? (y/n): " -NoNewline -ForegroundColor Yellow
                $commitChoice = Read-Host
                if ($commitChoice -eq 'y') {
                    git add .
                    git commit -m "Auto-fix $(Get-Date -Format 'yyyy-MM-dd')"
                }
            }
            
            Write-Host "3. Attempting push to GitHub..." -ForegroundColor Gray
            git push -u origin master 2>&1 | Tee-Object -Variable pushOutput
            
            Pop-Location
            Write-Host "`nDone with $($selectedRepo.Name)." -ForegroundColor Green
        }
    }
    '3' {
        Start-Process "https://github.com/MeekoThaRaccoon?tab=repositories"
        Write-Host "Browser opened. Compare your local list above with what's on GitHub." -ForegroundColor Cyan
    }
}

Write-Host "`nScript complete. Run it again anytime." -ForegroundColor Green
Pause