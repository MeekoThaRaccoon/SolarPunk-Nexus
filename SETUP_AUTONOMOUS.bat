@echo off
chcp 65001 > nul
title ⚡ SolarPunk Autonomous Setup
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║         SETTING UP AUTONOMOUS SYSTEM             ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📂 Creating sync script...
echo @echo off > SYNC_ALL.bat
echo cd /d "C:\Users\carol\SolarPunk" >> SYNC_ALL.bat
echo echo 🔄 Auto-sync at %%date%% %%time%% >> SYNC_ALL.bat
echo git add . 2>nul >> SYNC_ALL.bat
echo git commit -m "Auto-sync %%date%% %%time%%" 2>nul >> SYNC_ALL.bat
echo git push origin master 2>nul >> SYNC_ALL.bat
echo echo ✅ Synced to GitHub >> SYNC_ALL.bat
echo Cloudflare will auto-deploy in 30s >> SYNC_ALL.bat
echo pause >> SYNC_ALL.bat

echo ⚙️ Creating task scheduler script...
echo # Run this in PowerShell as Administrator > setup_task.ps1
echo \$action = New-ScheduledTaskAction -Execute 'C:\Users\carol\SolarPunk\SYNC_ALL.bat' >> setup_task.ps1
echo \$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) >> setup_task.ps1
echo \$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries >> setup_task.ps1
echo Register-ScheduledTask -TaskName "SolarPunk-AutoSync" -Action \$action -Trigger \$trigger -Settings \$settings -RunLevel Highest -Force >> setup_task.ps1
echo Write-Host "✅ Task created: Runs SYNC_ALL.bat every hour" -ForegroundColor Green >> setup_task.ps1

echo.
echo ✅ AUTONOMOUS SYSTEM READY
echo.
echo To enable hourly auto-sync:
echo   1. Right-click on setup_task.ps1
echo   2. "Run with PowerShell" (as Administrator)
echo   3. Confirm if prompted
echo.
echo System will now:
echo   • Auto-sync every hour
echo   • Auto-deploy to Cloudflare
echo   • Self-maintain
echo.
pause