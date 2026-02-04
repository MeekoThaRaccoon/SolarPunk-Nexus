# === SOLARPUNK PARALLEL MONITOR ===
# Run this to monitor everything simultaneously

function Monitor-GitHub {
    while($true) {
        $repos = "SolarPunk", "connected", "SolarPunk-Autonomous", "SolarPunk-Nexus"
        foreach ($r in $repos) {
            try {
                $status = (irm "https://api.github.com/repos/MeekoThaRaccoon/$r" -TimeoutSec 3).updated_at
                Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $r: OK" -ForegroundColor Green
            } catch {
                Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $r: ERROR" -ForegroundColor Red
            }
        }
        Start-Sleep -Seconds 30
    }
}

function Monitor-Cloudflare {
    while($true) {
        try {
            $status = (curl -s -o $null -w "%{http_code}" "https://solarpunk-nexus.pages.dev")
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Cloudflare: HTTP $status" -ForegroundColor Green
        } catch {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Cloudflare: DOWN" -ForegroundColor Red
        }
        Start-Sleep -Seconds 30
    }
}

# Run monitors in parallel
Start-Job -Name "GitHubMonitor" -ScriptBlock ${function:Monitor-GitHub}
Start-Job -Name "CloudflareMonitor" -ScriptBlock ${function:Monitor-Cloudflare}

Write-Host "Parallel monitoring started!" -ForegroundColor Cyan
Write-Host "Run: Get-Job | Receive-Job to see output" -ForegroundColor Yellow
