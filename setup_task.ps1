# Run this in PowerShell as Administrator 
\$action = New-ScheduledTaskAction -Execute 'C:\Users\carol\SolarPunk\SYNC_ALL.bat' 
\$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) 
\$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries 
Register-ScheduledTask -TaskName "SolarPunk-AutoSync" -Action \$action -Trigger \$trigger -Settings \$settings -RunLevel Highest -Force 
Write-Host "✅ Task created: Runs SYNC_ALL.bat every hour" -ForegroundColor Green 
