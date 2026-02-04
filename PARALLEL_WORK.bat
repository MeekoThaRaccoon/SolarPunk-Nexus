@echo off
echo === SOLARPUNK PARALLEL WORKSTATIONS ===
echo.
echo [1] Opening GitHub push windows...
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous && echo Pushing SolarPunk-Autonomous... && git push origin master && pause"
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk\SolarPunk-Nexus && echo Pushing SolarPunk-Nexus... && git push origin master && pause"

echo [2] Opening browser tabs...
start https://solarpunk-nexus.pages.dev
start https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous
start https://dash.cloudflare.com

echo [3] Opening monitoring...
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk && python quick_fix.py"

echo.
echo === ALL WINDOWS OPEN - WORK IN PARALLEL ===
echo 1. Watch GitHub pushes in PowerShell windows
echo 2. Check Cloudflare in browser
echo 3. Monitor with Python agent
echo.
pause