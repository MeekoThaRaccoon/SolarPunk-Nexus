@echo off
echo === SOLARPUNK ONE-CLICK FIX ALL ===
echo Running in parallel...

start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous && git push origin master"
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk\SolarPunk-Nexus && git push origin master"
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk && git push origin master"
start powershell -NoExit -Command "cd C:\Users\carol\SolarPunk\connected && git push origin master"

start "" "https://solarpunk-nexus.pages.dev"
start "" "https://github.com/MeekoThaRaccoon"
start "" "https://dash.cloudflare.com"

timeout /t 5
echo Check all opened windows for results!
pause
