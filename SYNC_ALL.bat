@echo off 
cd /d "C:\Users\carol\SolarPunk" 
echo Auto-sync running... 
git add . 
git commit -m "Auto-sync" 
git push origin master 
echo ✅ Synced 
pause 
