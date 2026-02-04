@echo off
echo === AUTONOMOUS REPO FIX ===
echo.
echo Adding remote for connected...
cd /d "C:\Users\carol\SolarPunk\connected"
git remote add origin https://github.com/YOUR_USERNAME/connected.git
git push -u origin master
echo Fixing SolarPunk-Autonomous...
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
git add .
git commit -m "Autonomous fix"
echo Create repo on GitHub: https://github.com/new
echo Name it exactly: SolarPunk-Autonomous
pause
echo Adding remote for SolarPunk-Nexus...
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Nexus"
git remote add origin https://github.com/YOUR_USERNAME/SolarPunk-Nexus.git
git push -u origin master
echo All fixes applied!
pause