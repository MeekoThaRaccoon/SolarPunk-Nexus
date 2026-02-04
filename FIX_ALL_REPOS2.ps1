# AUTONOMOUS GITHUB FIX FOR MEEKOTHARACCOON
# Save this as C:\Users\carol\SolarPunk\FIX_ALL_REPOS.ps1
# Then run: powershell -ExecutionPolicy Bypass -File FIX_ALL_REPOS.ps1

Write-Host "=== SOLARPUNK AUTONOMOUS REPO FIXER ===" -ForegroundColor Green
Write-Host "GitHub User: MeekoThaRaccoon" -ForegroundColor Cyan

# Find all git repos
$repos = Get-ChildItem -Path "C:\Users\carol\SolarPunk" -Directory -Recurse -Filter ".git" -Force

Write-Host "`nFound $($repos.Count) repositories:" -ForegroundColor Yellow

foreach ($git in $repos) {
    $repoPath = $git.Parent.FullName
    $repoName = $git.Parent.Name
    
    Write-Host "`n--- $repoName ---" -ForegroundColor Magenta
    
    # Change to repo directory
    Set-Location $repoPath
    
    # Check remote
    $remote = git remote -v 2>$null
    
    if ($remote -like "*github.com*") {
        if ($remote -like "*YOUR_USERNAME*" -or $remote -like "*placeholder*") {
            # Fix placeholder URL
            Write-Host "Fixing placeholder URL..." -ForegroundColor Yellow
            git remote remove origin 2>$null
            git remote add origin "https://github.com/MeekoThaRaccoon/$repoName.git"
            Write-Host "Set to: https://github.com/MeekoThaRaccoon/$repoName.git" -ForegroundColor Green
        } else {
            Write-Host "Remote OK: $($remote.Split()[1])" -ForegroundColor Green
        }
    } else {
        Write-Host "No GitHub remote found" -ForegroundColor Red
        Write-Host "Adding: https://github.com/MeekoThaRaccoon/$repoName.git" -ForegroundColor Yellow
        git remote add origin "https://github.com/MeekoThaRaccoon/$repoName.git" 2>$null
    }
    
    # Try to push
    Write-Host "Attempting push..." -ForegroundColor Gray
    $push = git push -u origin master 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Successfully pushed!" -ForegroundColor Green
    } elseif ($push -like "*repository not found*") {
        Write-Host "⚠ Repo doesn't exist on GitHub" -ForegroundColor Yellow
        Write-Host "  Create it: https://github.com/new?name=$repoName" -ForegroundColor Cyan
    } elseif ($push -like "*authentication*") {
        Write-Host "⚠ Need GitHub credentials" -ForegroundColor Red
        Write-Host "  Run: git credential-manager reject https://github.com" -ForegroundColor Cyan
    } else {
        Write-Host "✗ Push failed: $($push | Select-String -Pattern 'remote:' | Select-Object -First 1)" -ForegroundColor Red
    }
}

Write-Host "`n=== SUMMARY ===" -ForegroundColor Green
Write-Host "1. For missing repos: Visit https://github.com/MeekoThaRaccoon?tab=repositories" -ForegroundColor Yellow
Write-Host "2. Create any missing repos with EXACT names shown above" -ForegroundColor Yellow
Write-Host "3. Run this script again after creating missing repos" -ForegroundColor Yellow
Write-Host "`nNext: Install Cloudflare App for auto-deploy: https://github.com/apps/cloudflare-pages" -ForegroundColor Cyan

# Save report
$report = @"
=== AUTONOMOUS FIX REPORT ===
Date: $(Get-Date)
GitHub User: MeekoThaRaccoon
Repos Found: $($repos.Count)

NEXT ACTIONS:
1. Check: https://github.com/MeekoThaRaccoon?tab=repositories
2. Create any missing repositories
3. Run fix script again
4. Install Cloudflare GitHub App
"@

$report | Out-File "C:\Users\carol\SolarPunk\repo_fix_report.txt"
Write-Host "`nReport saved: C:\Users\carol\SolarPunk\repo_fix_report.txt" -ForegroundColor Gray